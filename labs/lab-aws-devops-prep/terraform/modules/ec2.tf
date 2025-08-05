resource "aws_instance" "example_server" {
  ami                         = "ami-0c65adc9a5c1b5d7c"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.nick_dev_key.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.example_sg.id]
  monitoring                  = true

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "NicksSample"
  }
}