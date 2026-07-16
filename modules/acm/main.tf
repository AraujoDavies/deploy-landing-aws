# ─────────────────────────────────────────────────────────────
# ACM certificate
# MUST be in us-east-1 — CloudFront only accepts certs from
# that region regardless of where the distribution is deployed.
# Ensure the provider passed to this module is aliased to us-east-1.
# ─────────────────────────────────────────────────────────────
resource "aws_acm_certificate" "main" {
  domain_name               = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}"]
  validation_method         = "DNS"

  # Allows in-place replacement of the cert without downtime
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-cert"
  })
}

# ─────────────────────────────────────────────────────────────
# Route 53 CNAME records — DNS validation
# ACM emits one CNAME per domain name in the cert.
# for_each collapses duplicates (apex + www often share one record).
# ─────────────────────────────────────────────────────────────
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.hosted_zone_id
}

# ─────────────────────────────────────────────────────────────
# Certificate validation — waits until ACM marks the cert ISSUED
# ─────────────────────────────────────────────────────────────
resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
}
