terraform {
  backend "s3" {
    bucket  = "teraform-up-and-running-arcones-state"
    region  = "eu-central-1"
    key     = "stage/services/data-stores/mysql/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_db_instance" "mysql_instance" {
  engine            = "mysql"
  allocated_storage = 20
  instance_class    = "db.t2.micro"
  name              = "terraformUpAndRunning_database"
  username          = "admin"
  password          = "${var.db_password}"
}
