provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
  profile = "mastermnd"
}

provider "github" {
  token        = var.github_token
  organization = var.github_organization
}

resource "aws_iam_user" "engineer" {
  count = length(var.engineer_name)
  name  = var.engineer_name[count.index]
}

resource "github_repository" "repos" {
  count       = length(var.git_repos)
  name        = var.git_repos[count.index]
  description = "Internal Covid Project"
}

resource "github_membership" "hub_users" {
  username = "brooksa321"
  role     = "member"
}

module "dev_server" {
  source        = "./developmentServers"
  machine_image = "ami-098f16afa9edf40be"
  machine_type  = "t3.micro"
  machine_key   = "hoist_dev"
}

