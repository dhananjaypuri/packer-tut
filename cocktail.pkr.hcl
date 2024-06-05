packer {
 required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }

}

variable "ami_id" {

    type = string
    default = "ami-067aaeea6813afbde"
}

source "amazon-ebs" "cocktails" {

    ami_name = "cocktails-ami"
    region = "ap-south-1"
    source_ami = "${var.ami_id}"
    instance_type = "t2.micro"
    ssh_username = "ec2-user"

}

build {

    sources = ["amazon-ebs.cocktails"]

    provisioner "file" {
        source = "cocktails_app.zip"
        destination = "/home/ec2-user/cocktails_app.zip"
    }

    provisioner "file" {
        source = "cocktails.service"
        destination = "/tmp/cocktails.service"
    }

    provisioner "shell" {
        script = "app.sh"
    }
}