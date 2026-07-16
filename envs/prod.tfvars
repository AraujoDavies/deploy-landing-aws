aws_region   = "us-east-1"
project_name = "landing-page"
environment  = "prod"

common_tags = {
  Environment = "prod"
  Project     = "landing-page"
  Owner       = "infra-team"
  ManagedBy   = "terraform"
}

index_document         = "index.html"
error_document         = "error.html"
cloudfront_price_class = "PriceClass_100"

# ── Custom domain ─────────────────────────────────────────────
# Replace with your actual domain registered in Route 53.
# The hosted zone must already exist before running terraform apply.
# Leave empty ("") to skip ACM + Route 53 and use the default
# *.cloudfront.net domain instead.
domain_name = "REPLACE_WITH_YOUR_DOMAIN.com"
