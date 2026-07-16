variable "domain_name" {
  description = "Root domain name (e.g. example.com)"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route 53 Hosted Zone ID that owns the domain"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "CloudFront distribution domain name (e.g. d1234abcd.cloudfront.net)"
  type        = string
}
