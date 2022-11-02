module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.4"
  name                   = local.object_name
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  iam_instance_profile   = aws_iam_instance_profile.profile-ted.name
  monitoring             = true
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.app_sg.security_group_id,module.ssh_sg.security_group_id]
  tags = local.common_tags
  volume_tags = local.volume_tags

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

}

