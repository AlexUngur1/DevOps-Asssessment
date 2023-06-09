packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

source "amazon-ebs" "app" {
  ami_name      = "packer-windows-demo-${local.timestamp}"
  instance_type = "t2.micro"
  region        = var.region

  source_ami_filter {
    filters = {
      name                = "packer-windows-demo-20230504142155"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }

    most_recent = true
    owners      = ["444401948418"]
  }
}

build {
  sources = ["source.amazon-ebs.app"]

  provisioner "file" {
    source      = "src/bin/Debug/net7.0/src.dll"
    destination = "C:\\inetpub\\wwwroot\\src.dll"
  }
}