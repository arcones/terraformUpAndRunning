provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "example" {
  ami           = "ami-38a01045"
  instance_type = "t2.nano"
  tags {
    Name = "terraform-example"
  }
}