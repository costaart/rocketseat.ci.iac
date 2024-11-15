terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
  }

  backend "s3" {
    bucket  = "rocketseat-iac-cursodocker"
    key     = "state/terraform.tfstate"
    region  = "us-east-2"
    # profile = "AdministratorAccess-651706743475"

  }
}

provider "aws" {
  region  = "us-east-2"
  # profile = "AdministratorAccess-651706743475"
}

resource "aws_s3_bucket" "terraform-state" {
  bucket        = "rocketseat-iac-cursodocker"
  force_destroy = true

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    IAC = "True"
  }
}

resource "aws_s3_bucket_versioning" "terraform-state" {
  bucket = "rocketseat-iac-cursodocker"

  versioning_configuration {
    status = "Enabled"
  }
}