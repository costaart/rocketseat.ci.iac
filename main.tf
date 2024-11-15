terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "AdministratorAccess-651706743475"
}