packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_name" {
  description = "The name of the AMI to be created"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the build"
  type        = string
}

variable "region" {
  description = "The AWS region where the build will be executed"
  type        = string
}

source "amazon-ebs" "amazon_linux" {
  ami_name      = var.ami_name
  instance_type = var.instance_type
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["137112412989"]
  }
  ssh_username = "ec2-user"
}

build {
  provisioner "shell" {
    script = "post-install.sh"
  }

  name = "madeo05-act1-packer"
  sources = [
    "source.amazon-ebs.amazon_linux"
  ]
}
