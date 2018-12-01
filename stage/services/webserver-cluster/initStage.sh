#!/bin/bash
terraform init -backend-config="key=stage/services/webserver-cluster/terraform.tfstate"
