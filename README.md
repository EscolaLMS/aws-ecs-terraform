# Wellms AWS `ecs` TerraForm files for one-click installation

Follow those steps to create instance of Wellms Headless LMS in your AWS environment

- install [git](https://git-scm.com/)
- install [terraform](https://developer.hashicorp.com/terraform/downloads)
- install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## 1. Login to your AWS

- Go to [your account](https://us-east-1.console.aws.amazon.com/iamv2/home?region=ue-central-1#/security_credentials) and generate Access Key
- use `aws configure` command from AWS CLI to login into AWS with command line tool. Select you're region, eg "eu-central-1"

## 2. Create `s3` bucket to persist your terraform state

- use `aws s3 mb s3://name-of-your-bucket-1111`

## 3. Pull this repository

- `git clone git@github.com:EscolaLMS/aws-ecs-terraform.git`

## 4. Replace `escola-terraform-states-all` with name of your bucket from previous point.

- in file [main.tf](main.tf), line 9 replace `escola-terraform-states-all` with your s3 bucket name name.

before

```tf
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
```

after

```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "name-of-your-bucket-1111"
    key    = "lms-ecs.tfstate"
    region = "eu-central-1"
  }
}
```

## 5. Deploy the environment

```bash
terraform init
terraform apply
```
