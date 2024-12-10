provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sergeis_sg_by_tf" {
  name        = "sergeis_sg_by_tf"
  description = "Made by tf"
  vpc_id = aws_vpc.sergeis_vpc_by_tf.id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "sergeis_vpc_by_tf" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_by_tf"
  }
}

resource "aws_subnet" "sergeis_subnet_by_tf" {
  vpc_id            = aws_vpc.sergeis_vpc_by_tf.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_by_tf"
  }
}

resource "aws_internet_gateway" "sergeis_igw_by_tf" {
  vpc_id = aws_vpc.sergeis_vpc_by_tf.id

  tags = {
    Name = "igw_by_tf"
  }
}

resource "aws_instance" "sergeis_by_tf" {
  ami           = "ami-0453ec754f44f9a4a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sergeis_sg_by_tf.id]
  subnet_id = aws_subnet.sergeis_subnet_by_tf.id

  tags = {
    Name = "ec_by_tf"
  }
}

output "created_vpc_instance_id" {
  value = aws_instance.sergeis_by_tf.id
}
