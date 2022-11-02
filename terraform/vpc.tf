module "vpc" {
  source = "terraform-aws-modules/vpc/aws"  
  version = "3.16.0"
  
  name = "${var.vpc_name}-${local.object_name}"
  cidr            = var.vpc_cidr_block
  azs             = var.vpc_availability_zones
  public_subnets  = var.vpc_public_subnets
 

  enable_vpn_gateway = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.common_tags
  vpc_tags = local.common_tags
  
}
