variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "common_tags" {
  description = "Tags applied to every taggable resource"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "my-project"
    Owner       = "infra-team"
    ManagedBy   = "terraform"
  }
}

variable "index_document" {
  description = "Default root object served by CloudFront (e.g. index.html)"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Custom error page path inside the bucket (e.g. error.html)"
  type        = string
  default     = "error.html"
}

variable "cloudfront_price_class" {
  description = "CloudFront price class (PriceClass_100 = US/EU only; cheapest for dev)"
  type        = string
  default     = "PriceClass_100"
}

variable "cloudfront_default_ttl" {
  description = "Default CloudFront cache TTL in seconds"
  type        = number
  default     = 86400
}

variable "cloudfront_max_ttl" {
  description = "Maximum CloudFront cache TTL in seconds"
  type        = number
  default     = 31536000
}

variable "cloudfront_min_ttl" {
  description = "Minimum CloudFront cache TTL in seconds"
  type        = number
  default     = 0
}

variable "certificate_arn" {
  description = "ACM certificate ARN for a custom domain (must be in us-east-1). Leave empty to use the default *.cloudfront.net certificate."
  type        = string
  default     = ""
}

variable "domain_aliases" {
  description = "Custom domain aliases to attach to the CloudFront distribution (e.g. [\"example.com\", \"www.example.com\"]). Requires certificate_arn to be set."
  type        = list(string)
  default     = []
}
