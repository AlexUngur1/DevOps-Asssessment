terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.my_vpc.id
}

resource "aws_instance" "my_instance" {
  count         = var.vm_count
  ami           = var.vm_image
  instance_type = var.vm_flavor
  subnet_id     = aws_subnet.my_subnet.id
  tags = {
    Name = "my-vm-${count.index}"
  }
}