data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "sensyne-health-tech-assignment-devops"
    key    = "vpc/terraform.tfstate"
    region = "eu-west-1"
  }
}
