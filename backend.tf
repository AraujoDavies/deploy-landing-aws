# Remote state — fill in your S3 bucket name before init.
# Never hard-code account IDs or credentials here.
# No DynamoDB lock table: safe for a single operator; avoid concurrent applies.
terraform {
  backend "s3" {
    bucket  = "REPLACE_WITH_YOUR_TFSTATE_BUCKET"
    key     = "static-website/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
