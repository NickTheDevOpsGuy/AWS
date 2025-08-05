resource "aws_key_pair" "nick_dev_key" {
  key_name   = "aws-devops-lab-key"
  public_key = file("~/.ssh/aws-devops-lab.pub")
}