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

output "route53_zone_id" {
  description = "Route 53 hosted zone ID (created when domain_name is set)"
  value       = var.domain_name != "" ? aws_route53_zone.main[0].zone_id : "N/A"
}

output "route53_nameservers" {
  description = "Route 53 nameservers — copy these 4 values into your domain registrar"
  value       = var.domain_name != "" ? aws_route53_zone.main[0].name_servers : []
}

output "nameserver_setup_instructions" {
  description = "Step-by-step instructions to point your registrar at the Route 53 nameservers"
  value = var.domain_name != "" ? <<-EOT
    Hosted zone created for: ${var.domain_name}

    Next step — register these nameservers at your domain provider:

    1. Open your domain registrar (Registro.br, GoDaddy, Namecheap, Cloudflare, etc.).
    2. Find DNS / Nameservers settings for ${var.domain_name}.
    3. Replace the current nameservers with these Route 53 values:
    ${join("\n", [for ns in aws_route53_zone.main[0].name_servers : "   - ${trimsuffix(ns, ".")}"])}
    4. Save and wait for DNS propagation (5 minutes to 48 hours).
    5. Re-run: terraform apply -var-file="envs/prod.tfvars"
       if ACM validation was still pending.

    Note: Terraform creates the hosted zone only. You must already own the domain
    at a registrar — this does not purchase/register a new domain.
  EOT
  : "N/A — set domain_name to enable custom domain / hosted zone"
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
