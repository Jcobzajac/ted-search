data "aws_instances" "prod" {
  instance_tags = {
      env = "prod"
    }

  filter {
    name   = "key-name"
    values = ["paris-zajac"]
  }
  filter {
    name   = "instance-type"
    values = [var.instance_type]
  }

}

data "aws_instances" "test" {
  instance_tags = {
      env = "test"
    }
    
  filter {
    name   = "key-name"
    values = ["paris-zajac"]
  }
  filter {
    name   = "instance-type"
    values = [var.instance_type]
  }

}

data "aws_instances" "general" {
  
  filter {
    name   = "key-name"
    values = ["paris-zajac"]
  }
  filter {
    name   = "instance-type"
    values = [var.instance_type]
  }

}

