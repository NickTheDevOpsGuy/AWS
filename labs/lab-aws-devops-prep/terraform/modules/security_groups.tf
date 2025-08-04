resource "aws_security_group" "example_sg" {
  name        = "example-server-sg"
  description = "Allow SSH and Node.js traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["136.226.75.22/32"]
  }

  ingress {
    description = "Allow Node.js"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["136.226.75.22/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}