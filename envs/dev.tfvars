aws_region   = "us-east-1"
project_name = "landing-page"
environment  = "dev"

common_tags = {
  Environment = "dev"
  Project     = "landing-page"
  Owner       = "infra-team"
  ManagedBy   = "terraform"
}

index_document         = "index.html"
error_document         = "error.html"
cloudfront_price_class = "PriceClass_100"
