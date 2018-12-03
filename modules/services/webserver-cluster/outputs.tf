output "elb_dns_name" {
  value = "${aws_elb.load_balancer.dns_name}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.scaling_group.name}"
}

output "elb_security_group_id" {
  value = "${aws_security_group.elb_security_group.id}"
}