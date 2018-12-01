#!/bin/bash
terraform init -backend-config="key=stage/services/data-stores/mysql/terraform.tfstate"
