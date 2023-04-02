variable "debian" {
    type = string
    default = "ami-0fec2c2e2017f4e7b"
}

variable "my-public-subnet-id" {}

variable "default-sg-id" {}

variable "key_name" {}

resource "aws_network_interface" "ic" {
    subnet_id = var.my-public-subnet-id # my-public-subnet
    
    tags = {
        lab = "terraform"
    }
}

resource "aws_instance" "hello-world" {
    ami = var.debian
    instance_type = "t2.micro"
    associate_public_ip_address = true
    vpc_security_group_ids = [var.default-sg-id]
    key_name = var.key_name

    network_interface {
        network_interface_id = aws_network_interface.ic.id
        device_index = 0
    }

    tags = {
        lab = "terraform"
    }
}


output "public_ip" {
  value = aws_instance.hello-world.public_ip
}