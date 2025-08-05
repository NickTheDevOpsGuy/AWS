# lab-aws-ssm-access-lab/main.tf

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
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ssm-access-lab-vpc"
  cidr = "10.1.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

# IAM Module
module "iam" {
  source = "./modules/iam"
}

# EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ssm-access-lab-sg"
  description = "Allow all egress"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssm-access-sg"
  }
}

# Get latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# EC2 Instance with SSM Access
resource "aws_instance" "ssm_ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  iam_instance_profile        = module.iam.ssm_instance_profile_name
  user_data                   = file("user_data.sh")

  tags = {
    Name = "ssm-enabled-instance"
  }
}

# Outputs
output "instance_id" {
  value = aws_instance.ssm_ec2.id
}

output "instance_public_ip" {
  value = aws_instance.ssm_ec2.public_ip
}