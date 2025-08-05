resource "aws_instance" "ssm_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.vpc.security_group_id]
  key_name                    = var.key_name

  iam_instance_profile        = module.iam.instance_profile_name

  user_data                   = file("${path.module}/user_data.sh")

  tags = {
    Name        = "ssm-ec2-instance"
    Environment = var.environment
  }
}