provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "example" {
  ami           = "ami-38a01045"
  instance_type = "t2.nano"
  user_data     = <<-EOF
                  #!/bin/bash
                  echo "Hello arcones" > index.html
                  nohup busybox httpd -f -p 8080 &
                  EOF
  tags {
    Name = "terraform-example"
  }
}