# ─────────────────────────────────────────────────────────────
# CloudFront has a single fixed hosted zone ID used for all
# alias records regardless of region or distribution.
# ─────────────────────────────────────────────────────────────
locals {
  cloudfront_hosted_zone_id = "Z2FDTNDATAQYW2"
}

# ─────────────────────────────────────────────────────────────
# Apex domain — A + AAAA alias records (example.com)
# ─────────────────────────────────────────────────────────────
resource "aws_route53_record" "apex_a" {
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = local.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "apex_aaaa" {
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "AAAA"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = local.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}

# ─────────────────────────────────────────────────────────────
# www subdomain — A + AAAA alias records (www.example.com)
# ─────────────────────────────────────────────────────────────
resource "aws_route53_record" "www_a" {
  zone_id = var.hosted_zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = local.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_aaaa" {
  zone_id = var.hosted_zone_id
  name    = "www.${var.domain_name}"
  type    = "AAAA"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = local.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}
