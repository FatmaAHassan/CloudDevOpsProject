terraform {
  backend "s3" {
    bucket         = "cloud-devops-project-terraform-state-fatma"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
