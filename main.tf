# ─────────────────────────────────────────────────────────────
# Route 53 — create a public hosted zone for the custom domain.
# Only executed when var.domain_name is provided.
# After apply, copy the NS output into your domain registrar.
# ─────────────────────────────────────────────────────────────
resource "aws_route53_zone" "main" {
  count = var.domain_name != "" ? 1 : 0
  name  = var.domain_name

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-zone"
  })
}

# ─────────────────────────────────────────────────────────────
# ACM certificate — covers apex + www, validated via Route 53.
# The provider MUST be in us-east-1 (CloudFront requirement).
# ─────────────────────────────────────────────────────────────
module "acm" {
  count  = var.domain_name != "" ? 1 : 0
  source = "./modules/acm"

  project_name   = var.project_name
  environment    = var.environment
  domain_name    = var.domain_name
  hosted_zone_id = aws_route53_zone.main[0].zone_id
  common_tags    = var.common_tags
}

# ─────────────────────────────────────────────────────────────
# Static website — S3 + CloudFront
# ─────────────────────────────────────────────────────────────
module "static_website" {
  source = "./modules/static-website"

  project_name           = var.project_name
  environment            = var.environment
  common_tags            = var.common_tags
  index_document         = var.index_document
  error_document         = var.error_document
  cloudfront_price_class = var.cloudfront_price_class

  certificate_arn = var.domain_name != "" ? module.acm[0].certificate_arn : ""
  domain_aliases  = var.domain_name != "" ? [var.domain_name, "www.${var.domain_name}"] : []
}

# ─────────────────────────────────────────────────────────────
# Route 53 alias records — apex + www → CloudFront
# ─────────────────────────────────────────────────────────────
module "route53" {
  count  = var.domain_name != "" ? 1 : 0
  source = "./modules/route53"

  domain_name            = var.domain_name
  hosted_zone_id         = aws_route53_zone.main[0].zone_id
  cloudfront_domain_name = module.static_website.cloudfront_domain_name

  depends_on = [module.acm]
}
