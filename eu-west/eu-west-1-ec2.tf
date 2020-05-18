# from https://www.terraform.io/docs/providers/aws/r/instance.html
# Create a new instance of an Ubuntu 16.04 on an
# t2.micro node with an AWS Tag naming it "armory-pov"
provider "aws" {
  region = "eu-west-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20200429"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "0a4fbfab82b4aee91"
  instance_type = "t2.micro"

  tags = {
    Name = "armory-pov"
  }
}
