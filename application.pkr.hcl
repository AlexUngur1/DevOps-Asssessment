packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/amazon"
    }
  }
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

source "amazon-ebs" "app" {
  ami_name      = "packer-windows-demo-20230503103444 {{timestamp}}"
  instance_type = "t2.micro"
  region        = "${var.region}"
  source_ami    = "ami-0f0532c1b6e6abe57"
}

build {
  name = "app"
  sources = [
    "source.amazon-ebs.app"
  ]

  provisioner "file" {
    source      = "app/"
    destination = "C:\\inetpub\\wwwroot\\app"
  }

  provisioner "powershell" {
    inline = [
      "Import-Module WebAdministration",
      "New-WebApplication -Name 'app' -Site 'Default Web Site' -PhysicalPath 'C:\\inetpub\\wwwroot\\app'"
    ]
  }
}

