terraform {
  backend "s3" {
    bucket  = "teraform-up-and-running-arcones-state"
    region  = "eu-central-1"
    encrypt = true
    key     = "stage/services/webserver-cluster/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"
  environment = "stage"
}