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
# Replace with your already-owned domain (e.g. mysite.com.br).
# Terraform creates the Route 53 hosted zone automatically.
# After apply, copy route53_nameservers / nameserver_setup_instructions
# into your domain registrar (Registro.br, GoDaddy, etc.).
# Leave empty ("") to skip ACM + Route 53 and use the default
# *.cloudfront.net domain instead.
domain_name = "REPLACE_WITH_YOUR_DOMAIN"
