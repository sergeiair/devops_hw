data "aws_ssm_parameter" "vpc_cidr" {
  name = "sergeis_vpc_cidr"
}

data "aws_ssm_parameter" "public_subnet_1" {
  name = "sergeis_public_subnet_1"
}

data "aws_ssm_parameter" "public_subnet_2" {
  name = "sergeis_public_subnet_2"
}

resource "aws_vpc" "main" {
  cidr_block = data.aws_ssm_parameter.vpc_cidr.value

  tags = {
    Name = "sergeis-main-vpc"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = data.aws_ssm_parameter.public_subnet_1.value
  map_public_ip_on_launch = true

  tags = {
    Name = "sergeis-public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = data.aws_ssm_parameter.public_subnet_2.value
  map_public_ip_on_launch = true

  tags = {
    Name = "sergeis-public-subnet-2"
  }
}
