resource "aws_security_group" "madeo05act1_sg" {
  name   = "madeo05act1-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    terraform = true
  }

}

resource "aws_instance" "madeo05act1" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = local.public1_subnet_id
  vpc_security_group_ids      = [aws_security_group.madeo05act1_sg.id]
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true

  }

  tags = {
    terraform = true
    materia = "madeo05act1"
  }
}