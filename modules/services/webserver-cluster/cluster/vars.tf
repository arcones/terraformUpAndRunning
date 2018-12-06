variable "server_port" {}
variable "instance_type" {}
variable "min_size" {}
variable "max_size" {}
variable "elb_id" {}
variable "cluster_name" {}
variable "db_remote_state_bucket" {}
variable "db_remote_state_key" {}

variable "availability_zones_names" {
  type = "list"
}
