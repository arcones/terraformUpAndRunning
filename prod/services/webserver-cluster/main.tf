terraform {
  backend "s3" {
    bucket  = "teraform-up-and-running-arcones-state"
    region  = "eu-central-1"
    encrypt = true
    key     = "prod/services/webserver-cluster/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_autoscaling_schedule" "scale_out_during_bussiness_hours" {
  scheduled_action_name = "scale_out_during_bussiness_hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 10
  recurrence            = "0 9 * * *"

  autoscaling_group_name = "${module.webserver_cluster.asg_name}"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale_in_at_night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *"

  autoscaling_group_name = "${module.webserver_cluster.asg_name}"
}

module "webserver_cluster" {
  source                 = "../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "teraform-up-and-running-arcones-state"
  db_remote_state_key    = "prod/services/data-stores/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 2
  max_size               = 10
}
