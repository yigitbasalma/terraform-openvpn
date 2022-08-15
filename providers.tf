terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    curl = {
      source = "anschoewe/curl"
      version = "0.1.4"
    }
  }
}

# Configure default provider
provider "aws" {
  region = var.region
}

provider "curl" {}