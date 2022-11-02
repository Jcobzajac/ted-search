module "app_sg" {
  source  = "terraform-aws-modules/security-group/aws" 
  version = "4.13.1"

  name = "app_security_group-${local.object_name}"
  description = "Security Group with HTTP & SSH"
  vpc_id = module.vpc.vpc_id
  # Inbound traffic only from vpcs cidr block
  #ingress_rules = ["ssh-tcp", "http-80-tcp"]
  #ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 9191
      to_port     = 9191
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.1"

  name = "ssh_security_group-${local.object_name}"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}
