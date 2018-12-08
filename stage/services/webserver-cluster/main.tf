module "webserver_cluster" {
  source                 = "../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "teraform-up-and-running-arcones-state"
  db_remote_state_key    = "stage/services/data-stores/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 2
  max_size               = 2
  key_pair_name          = "${aws_key_pair.ec2_ssh_key.key_name}"
}

resource "aws_security_group_rule" "allow_testing_inbound_elb" {
  type              = "ingress"
  security_group_id = "${module.webserver_cluster.elb_security_group_id}"

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_key_pair" "ec2_ssh_key" {
  key_name   = "slimbook"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_security_group_rule" "ssh_ec2_inbound" {
  type              = "ingress"
  security_group_id = "${module.webserver_cluster.ec2_security_group_id}"

  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["77.228.112.250/32"]
}

resource "aws_security_group_rule" "ssh_ec2_outbound" {
  type              = "egress"
  security_group_id = "${module.webserver_cluster.ec2_security_group_id}"

  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
