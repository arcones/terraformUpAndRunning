output "address" {
  value = "${aws_db_instance.mysql_instance.address}"
}

output "port" {
  value = "${aws_db_instance.mysql_instance.port}"
}
