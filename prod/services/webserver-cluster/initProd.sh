#!/bin/bash
terraform init -backend-config="key=prod/services/webserver-cluster/terraform.tfstate"
