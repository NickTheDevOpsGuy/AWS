variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "key_pair_name" {
  description = "Name of the SSH key pair to use for EC2"
  type        = string
  default     = "aws-devops-lab-key"
}

variable "ssh_cidr_block" {
  description = "CIDR block allowed to SSH into EC2"
  type        = string
  default     = "136.226.75.22/32"
}

variable "node_port" {
  description = "Port for the Node.js application"
  type        = number
  default     = 5000
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c65adc9a5c1b5d7c" # Ubuntu 22.04 LTS (x86_64)
}