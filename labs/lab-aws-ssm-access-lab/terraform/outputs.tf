output "ssm_instance_id" {
  description = "The ID of the EC2 instance with SSM access"
  value       = aws_instance.ssm_ec2.id
}

output "ssm_instance_public_ip" {
  description = "The public IP of the EC2 instance (if applicable)"
  value       = aws_instance.ssm_ec2.public_ip
}

output "instance_profile_name" {
  value       = module.iam.ssm_instance_profile_name  # ✅ Match the output name in the IAM module
}