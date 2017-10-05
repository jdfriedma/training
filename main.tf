#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-ecc63a94
#
# Your subnet ID is:
#
#     subnet-b622aed0
#
# Your security group ID is:
#
#     sg-55f65f28
#
# Your Identity is:
#
#     test-training-jb-mole
#

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "count" {}

variable "aws_region" {
  default = "us-west-2"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-ecc63a94"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-b622aed0"
  vpc_security_group_ids = ["sg-55f65f28"]
  count                  = 3

  tags = {
    Identity = "test-training-jb-mole"
    Tag2     = "testing"
    Tag3     = "testingagain"
    Name     = "web ${count.index + 1}/${var.count}"
  }
}

terraform {
  backend "atlas" {
    name = "jdfriedman/training"
  }
}

output "address" {
  value = ["${aws_instance.web.*.public_dns}"]
}

output "IP" {
  value = ["${aws_instance.web.*.public_ip}"]
}
