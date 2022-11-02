locals {
    owner = "${var.name}-${var.surname}"
    common_tags = {
        bootcamp = var.bootcamp
        created_by = "${var.name}-${var.surname}"
        env = var.env
    }
    counter_instances = "${length(data.aws_instances.test.ids) + 1}"
    volume_tags = {
        Name = "Jakub Zajac"
        bootcamp = "poland1"
        created_by = "Jakub Zajac"
    }
    object_name = "${local.owner}-TED-${var.env}-${length(data.aws_instances.general.ids) + 1}"
    user_data = <<-EOT
        #!/bin/bash
        sleep 5
        sudo su
        apt-get update
        apt install docker.io -y
        apt install docker-compose -y
        groupadd docker
        usermod -aG docker $USER
        newgrp docker
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        apt install unzip
        unzip awscliv2.zip
        ./aws/install
        EOT
}
