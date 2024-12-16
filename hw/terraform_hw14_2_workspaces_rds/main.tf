provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "sergeis-${terraform.workspace}-vpc"
  }
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_@-"
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/${terraform.workspace}/rds/password"
  description = "RDS password for ${terraform.workspace}"
  type        = "SecureString"
  value       = random_password.db_password.result
}

resource "aws_db_instance" "main" {
  allocated_storage      = 20
  max_allocated_storage  = 30
  engine                 = "postgres"
  engine_version         = "17.2"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = random_password.db_password.result
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot    = true
  tags = {
    Name = "sergeis-${terraform.workspace}-rds"
  }
}

resource "aws_security_group" "db" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 5432
    to_port     = 5432
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
    Name = "sergeis-${terraform.workspace}-db-sg"
  }
}

resource "aws_subnet" "main" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "sergeis-${terraform.workspace}-subnet-${count.index}"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "sergeis-${terraform.workspace}-subnet-group"
  subnet_ids = aws_subnet.main[*].id
  tags = {
    Name = "sergeis-${terraform.workspace}-subnet-group"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
