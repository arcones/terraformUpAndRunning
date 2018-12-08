output "auto_scaling_group_name" {
  value = "${aws_autoscaling_group.scaling_group.name}"
}

output "security_group_id" {
  value = "${aws_security_group.security_group_ec2.id}"
}
