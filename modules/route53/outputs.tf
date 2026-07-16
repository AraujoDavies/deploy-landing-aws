output "apex_fqdn" {
  description = "Fully qualified domain name of the apex A record"
  value       = aws_route53_record.apex_a.fqdn
}

output "www_fqdn" {
  description = "Fully qualified domain name of the www A record"
  value       = aws_route53_record.www_a.fqdn
}
