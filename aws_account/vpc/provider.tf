terraform {
  backend "s3" {}
}

provider "aws" {
  region  = "eu-west-1"
  profile = "default"
}


