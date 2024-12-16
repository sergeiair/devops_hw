module "vpc_parameters" {
  source  = "terraform-aws-modules/ssm-parameter/aws"
  version = "1.1.2"

  for_each = {
    "sergeis_vpc_cidr"        = "10.0.0.0/16"
    "sergeis_public_subnet_1" = "10.0.1.0/24"
    "sergeis_public_subnet_2" = "10.0.2.0/24"
  }

  name  = each.key
  value = each.value
}
