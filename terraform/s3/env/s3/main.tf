provider "aws" {
  region = local.region
}

variable "buckets" {
  type = list(string)
  default = []
}

locals {
  region = "eu-central-1"
  buckets = var.buckets
}

module "s3_bucket" {
  count = length(local.buckets)

  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = local.buckets[count.index]
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
