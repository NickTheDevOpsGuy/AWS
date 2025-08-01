terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "nick_dev_key" {
  key_name   = "aws-devops-lab-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "example_sg" {
  name        = "example-server-sg"
  description = "Allow SSH and Node.js traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["<yourIP>/32"]
  }

  ingress {
    description = "Allow Node.js"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["<yourIP>/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example_server" {
  ami                         = "ami-04e914639d0cca79a"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.nick_dev_key.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.example_sg.id]

    user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nodejs npm git

              # Clone sample Node.js app (replace with your repo if needed)
              git clone https://github.com/heroku/node-js-sample.git /opt/node-app

              cd /opt/node-app
              npm install

              # Start app in background on port 3000
              nohup npm start &
              EOF

  tags = {
    Name = "NicksSample"
  }
}

output "ec2_instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.example_server.public_ip
}

output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.example_server.id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "web_app_url" {
  description = "Access URL for the Node.js app"
  value       = "http://${aws_instance.example_server.public_ip}:3000"
}