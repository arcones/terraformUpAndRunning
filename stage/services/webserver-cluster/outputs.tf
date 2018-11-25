output "elb_dns_name" {
  value = "${aws_elb.load_balancer.dns_name}"
}

output "database_port" {
  value = "${data.terraform_remote_state.db.port}"
}
