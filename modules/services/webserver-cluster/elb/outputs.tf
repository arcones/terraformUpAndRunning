output "dns_name" {
  value = "${aws_elb.load_balancer.dns_name}"
}

output "security_group_id" {
  value = "${aws_security_group.elb_security_group.id}"
}

output "id" {
  value = "${aws_elb.load_balancer.id}"
}
