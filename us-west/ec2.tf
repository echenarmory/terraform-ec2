# from https://www.terraform.io/docs/providers/aws/r/instance.html
# Create a new instance of an Ubuntu 16.04 on an
# t2.micro node with an AWS Tag naming it "armory-pov"
terraform {
  backend "s3" {}
}
provider "aws" {
  region = "us-west-2"
}
variable "environment_name" {
  default = "hello"
}

resource "aws_s3_bucket" "b" {
  bucket = "terraformer-demo-${var.environment_name}"
  acl    = "public-read"

  tags = {
    Name = "Bucket for ${var.environment_name}"
  }
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
  ami           = "ami-0813245c0939ab3ca"
  instance_type = "t2.micro"

  tags = {
    Name = "armory-pov"
  }
}
