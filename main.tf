terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "escola-terraform-states-all"
    key    = "lms-ecs.tfstate"
    region = "eu-central-1"
  }
}
provider "aws" {
  region = "${var.region}"
  default_tags {
    tags = {
      env-name         = "${var.env-name}"
    }
  }
}

resource "random_string" "name" {
  length   = 6
  lower    = true
  upper    = false
  special  = false
  numeric  = false
}

resource "random_password" "db" {
  length           = 12
  special          = false
}

locals {
  production_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "Networking" {
  source               = "./modules/Networking"
  name                 = random_string.name.result
  region               = var.region
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = local.production_availability_zones

}

