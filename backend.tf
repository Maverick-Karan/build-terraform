terraform {
  backend "s3" {
    bucket         = "build-remotestate"
    key            = "default/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "build-state-locking"
    encrypt        = "true"
  }
}