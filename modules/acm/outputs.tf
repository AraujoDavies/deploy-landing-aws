output "certificate_arn" {
  description = "ARN of the issued ACM certificate — pass to the static-website module"
  value       = aws_acm_certificate_validation.main.certificate_arn
}

output "certificate_domain" {
  description = "Primary domain name on the certificate"
  value       = aws_acm_certificate.main.domain_name
}
