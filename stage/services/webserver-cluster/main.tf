terraform {
  backend "s3" {
    bucket  = "teraform-up-and-running-arcones-state"
    region  = "eu-central-1"
    key     = "stage/services/webserver-cluster/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

data "aws_availability_zones" "all" {}

data "terraform_remote_state" "db" {
  backend = "s3"

  config {
    bucket = "teraform-up-and-running-arcones-state"
    key    = "stage/services/data-stores/mysql/terraform.tfstate"
    region = "eu-central-1"
  }
}

## EC2 AUTOSCALING GROUP CONFIGURATION

resource "aws_launch_configuration" "instances" {
  image_id        = "ami-0fad7824ed21125b1"
  instance_type   = "t2.nano"
  security_groups = ["${aws_security_group.security_group.id}"]

  user_data = <<-EOF
                  #!/bin/bash
                  echo "Hello arcones" >> index.html
                  echo "${data.terraform_remote_state.db.address}" >> index.html
                  echo "${data.terraform_remote_state.db.port}" >> index.html
                  nohup busybox httpd -f -p ${var.server_port} &
                  EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "scaling_group" {
  launch_configuration = "${aws_launch_configuration.instances.id}"
  availability_zones   = ["${data.aws_availability_zones.all.names}"]

  load_balancers    = ["${aws_elb.load_balancer.id}"]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tags {
    key                 = "Name"
    value               = "terraformUpAndRunning"
    propagate_at_launch = true
  }
}

## ELASTIC LOAD BALANCER

resource "aws_elb" "load_balancer" {
  name               = "myELB"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  security_groups    = ["${aws_security_group.elb_security_group.id}"]

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.server_port}"
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.server_port}/"
  }
}

resource "aws_security_group" "elb_security_group" {
  name = "myELBSecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## SECURITY GROUP

resource "aws_security_group" "security_group" {
  name        = "security-group"
  description = "Security group for AWS EC2 instance"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
