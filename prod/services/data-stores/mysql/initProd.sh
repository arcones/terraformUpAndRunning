#!/bin/bash
terraform init -backend-config="key=prod/services/data-stores/mysql/terraform.tfstate"
