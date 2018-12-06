resource "aws_elb" "load_balancer" {
  name               = "myELB-${var.cluster_name}"
  availability_zones = ["${var.availability_zones_names}"]
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
  name        = "${var.cluster_name}"
  description = "Security group from the AWS ELB"
}

resource "aws_security_group_rule" "allow_all_outbound_elb" {
  type              = "egress"
  security_group_id = "${aws_security_group.elb_security_group.id}"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_http_inbound_elb" {
  type              = "ingress"
  security_group_id = "${aws_security_group.elb_security_group.id}"

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
