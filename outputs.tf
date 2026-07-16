output "website_url" {
  description = "Public HTTPS URL of the static website"
  value       = module.static_website.website_url
}

output "content_bucket_name" {
  description = "S3 bucket name — upload your HTML files here"
  value       = module.static_website.content_bucket_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID — use for cache invalidations"
  value       = module.static_website.cloudfront_distribution_id
}

output "cloudfront_domain_name" {
  description = "CloudFront domain name"
  value       = module.static_website.cloudfront_domain_name
}

output "cloudfront_cdn_endpoint" {
  description = "Raw CloudFront CDN endpoint — use as CNAME target if managing DNS outside Route 53"
  value       = module.static_website.cloudfront_domain_name
}

output "route53_nameservers" {
  description = "Route 53 nameservers — copy these 4 values into your domain registrar"
  value       = var.domain_name != "" ? data.aws_route53_zone.main[0].name_servers : []
}

output "certificate_arn" {
  description = "ACM certificate ARN (only set when domain_name is provided)"
  value       = var.domain_name != "" ? module.acm[0].certificate_arn : "N/A — using default CloudFront certificate"
}

output "apex_url" {
  description = "Apex domain URL (only set when domain_name is provided)"
  value       = var.domain_name != "" ? "https://${var.domain_name}" : "N/A"
}

output "www_url" {
  description = "WWW domain URL (only set when domain_name is provided)"
  value       = var.domain_name != "" ? "https://www.${var.domain_name}" : "N/A"
}
