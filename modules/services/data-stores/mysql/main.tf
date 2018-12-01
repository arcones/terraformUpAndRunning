terraform {
  backend "s3" {
    bucket  = "teraform-up-and-running-arcones-state"
    region  = "eu-central-1"
    encrypt = true
  }
}

resource "aws_db_instance" "mysql_instance" {
  engine            = "mysql"
  allocated_storage = 20
  instance_class    = "db.t2.micro"
  name              = "terraformUpAndRunning_database"
  username          = "admin"
  password          = "${var.db_password}"
  skip_final_snapshot = true
}
