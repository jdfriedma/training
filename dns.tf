variable "dnsimple_token" {
  default = "1234567890"
}

variable "dnsimple_account" {
  default = "foobar"
}

provider "dnsimple" {
  token   = "${var.dnsimple_token}"
  account = "${var.dnsimple_account}"
}

# Create a record
resource "dnsimple_record" "whatever" {
  domain = "foo.bar"
  type   = "A"
  name   = "agincourt"
  value  = "${aws_instance.web.0.public_ip}"
}
