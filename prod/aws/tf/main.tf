provider "kubernetes" {
  host                   = module.bozobooks_eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.bozobooks_eks.cluster_certificate_authority_data)
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "bozobooks-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}