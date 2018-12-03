terraform {
  backend "s3" {
    bucket  = "teraform-up-and-running-arcones-state"
    region  = "eu-central-1"
    key     = "global/s3/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  profile  = "explorationAccount"
  region   = "eu-central-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "teraform-up-and-running-arcones-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
