
provider "aws" {
  region = "us-east-1"
}

locals {
  security_group_id = "sg-0080a990bb0d5f774"
}

data "aws_security_group" "one_sg" {
  id = local.security_group_id
}

output "security_group_info" {
  value = {
    id          = data.aws_security_group.one_sg.id
    name        = data.aws_security_group.one_sg.name
    description = data.aws_security_group.one_sg.description
    vpc_id      = data.aws_security_group.one_sg.vpc_id
  }
}
