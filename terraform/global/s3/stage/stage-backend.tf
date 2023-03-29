terraform {
  required_providers {
    
    aws = {
      source  = "hashicorp/aws"
      version = "3.38"
    }
  }
  required_version = "0.15.3"
}

provider "aws" {
  region = "us-east-2"
}

module "backend_config" {
  source = "../../../modules/backends/s3"

  bucket_name = "nomad-stage-state-bucket"
  dynamodb_name = "nomad-stage-table-locks" 
}

terraform {
  backend "s3" {
    # set bucket details
    bucket = "nomad-stage-state-bucket"
    key = "global/s3/stage/terraform.tfstate" 
    region = "us-east-2"

    # dynamo db table details for locking
    dynamodb_table = "nomad-stage-table-locks"
    encrypt = true
  }
}