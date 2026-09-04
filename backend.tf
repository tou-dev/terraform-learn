terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    skip_credentials_validation  = true
    skip_metadata_api_check      = true
    skip_region_validation       = true
    skip_requesting_account_id   = true # Bypasses the AWS account ID check
    force_path_style             = true

    endpoints = {
      s3 = "https://placeholder-endpoint-will-be-overridden-in-ci"
    }
  }
}