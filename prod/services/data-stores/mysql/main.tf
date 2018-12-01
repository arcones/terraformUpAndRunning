provider "aws" {
  region = "eu-central-1"
}

module "mysql" {
  source = "../../../../modules/services/data-stores/mysql"
  db_password = "${var.db_password}"
}