resource "aws_db_instance" "mysql_instance" {
  name              = "terraformUpAndRunning_database"
  engine            = "mysql"
  allocated_storage = 20
  instance_class    = "db.t2.micro"
  username          = "admin"
  password          = "${var.db_password}"
  skip_final_snapshot = true
}
