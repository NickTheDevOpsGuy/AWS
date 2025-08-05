variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "aws-devops-lab-key"
}

variable "public_key_path" {
  description = "Path to the public key"
  type        = string
  default     = "~/.ssh/aws-devops-lab.pub"
}

variable "ubuntu_ami" {
  description = "Ubuntu AMI ID for EC2 instance"
  type        = string
  # Update this if needed based on region and latest Ubuntu image
  default     = "ami-0c65adc9a5c1b5d7c"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}