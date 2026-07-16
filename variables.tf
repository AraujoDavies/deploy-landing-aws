variable "aws_region" {
  description = "Primary AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name — used in resource names and tags"
  type        = string
}

variable "environment" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
}

variable "common_tags" {
  description = "Tags merged onto every resource created by the root module and all child modules"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "my-project"
    Owner       = "infra-team"
    ManagedBy   = "terraform"
  }
}

variable "index_document" {
  description = "Default root object (e.g. index.html)"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Custom error page inside the S3 bucket (e.g. error.html)"
  type        = string
  default     = "error.html"
}

variable "cloudfront_price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}

# ─────────────────────────────────────────────────────────────
# Custom domain — optional; leave empty for dev/staging
# ─────────────────────────────────────────────────────────────
variable "domain_name" {
  description = "Root domain name for the website (e.g. example.com). When set, ACM + Route 53 records are created. Leave empty to use the default *.cloudfront.net domain."
  type        = string
  default     = ""
}
