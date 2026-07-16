variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
}

variable "domain_name" {
  description = "Root domain name (e.g. example.com). The certificate will cover both the apex and www subdomain."
  type        = string
}

variable "hosted_zone_id" {
  description = "Route 53 Hosted Zone ID that contains the domain"
  type        = string
}

variable "common_tags" {
  description = "Tags applied to every taggable resource"
  type        = map(string)
  default = {
    Environment = "prod"
    Project     = "my-project"
    Owner       = "infra-team"
    ManagedBy   = "terraform"
  }
}
