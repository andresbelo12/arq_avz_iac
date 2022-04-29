resource "aws_key_pair" "key" {
  key_name   = "andres-clave"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDN5nHbWBiFxv7OLj4hsRV/z9UP/TRbMbZmUF2Wo5UYfjOZw8mOOd+kUXqYC8TVFdhf8NETnP+jQNNMEJ3wwgiL939cNsnwhIt/0EnYQSLfFeo5d7VpJOmZ8p1tbMldG9RSvKZEA5kxyP30Rq+KEfWVMhjn96Jr/yJ5jg3dkplTz2+qaOCKrBOs41hpMNRuvkS8d2MRxNG6uuDob3q+bbTyMgEDWkzmyFoyn5LbiKqMhPcpsPCJz0yaQblcIaokicGO8DHCB2GPMrHOZU0tZ/uGp1L7E9+TwVicSNTgiwRG4jWleNv1B6MnDMqRYd+rYXy7PhmPwlo1k8pLs32nxxOxmN0omNymZToCmTuydZpZUMYybkTwoYzmTZA9y8k9pjK8wU5a2NybLcSI0ZhXckCd7TjPaOuRAJKMJ4Q4R+r0zCdgQ5tpUKkKkaTqKNVP/O8lBSCNN8N7EsmwUVVFkbBX0RfN7u8o92XP9Srg8VkWQQvKM0C8mISF7RN7AS+Gu9E= andre@DESKTOP-QSA6EGN"
}

resource "aws_instance" "frontend" {
    ami                         = "ami-04505e74c0741db8d"
    instance_type               = "t2.micro"
    vpc_security_group_ids      = ["${aws_security_group.frontend_sg.id}"]
    key_name                    = aws_key_pair.key.key_name
    subnet_id                   = "subnet-0ccca92a28e1840e2"
    user_data                   = data.template_file.template.rendered
}

data "template_file" "template"{
    template = file("${path.module}/init.sh")
    vars = {
        BACKEND_URL = var.BACKEND_URL
    }
}

variable "BACKEND_URL" {
    description = "List of outbound rules for Bastion instances"
    type = string
    default = "localhost"
}