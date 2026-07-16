# module: static-website

Deploys a production-grade static website on AWS using:

- **S3** (private bucket, SSE-S3 encryption, versioning, lifecycle rules)
- **CloudFront** (OAC, HTTPS-only, IPv6)

All traffic is redirected to HTTPS. The S3 bucket is never directly reachable from the internet.

## Usage

```hcl
module "static_website" {
  source = "./modules/static-website"

  project_name = "my-project"
  environment  = "dev"

  common_tags = {
    Environment = "dev"
    Project     = "my-project"
    Owner       = "infra-team"
    ManagedBy   = "terraform"
  }
}
```

## Upload a page

After `terraform apply`, upload your HTML file to the content bucket:

```bash
aws s3 cp index.html s3://<content_bucket_name>/index.html
```

Then invalidate the CloudFront cache if needed:

```bash
aws cloudfront create-invalidation \
  --distribution-id <cloudfront_distribution_id> \
  --paths "/*"
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `project_name` | Project name for naming and tagging | `string` | — | yes |
| `environment` | dev / staging / prod | `string` | — | yes |
| `common_tags` | Tags applied to every resource | `map(string)` | see variables.tf | no |
| `index_document` | CloudFront default root object | `string` | `index.html` | no |
| `error_document` | Custom 404 page path in bucket | `string` | `error.html` | no |
| `cloudfront_price_class` | CloudFront price class | `string` | `PriceClass_100` | no |
| `cloudfront_default_ttl` | Default cache TTL (seconds) | `number` | `86400` | no |
| `cloudfront_max_ttl` | Max cache TTL (seconds) | `number` | `31536000` | no |
| `cloudfront_min_ttl` | Min cache TTL (seconds) | `number` | `0` | no |
| `certificate_arn` | ACM cert ARN for custom domain (us-east-1) | `string` | `""` | no |
| `domain_aliases` | Custom domain aliases for CloudFront | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| `website_url` | Full HTTPS URL (https://\<domain\>.cloudfront.net) |
| `content_bucket_name` | S3 content bucket name |
| `content_bucket_arn` | S3 content bucket ARN |
| `cloudfront_distribution_id` | CloudFront distribution ID |
| `cloudfront_distribution_arn` | CloudFront distribution ARN |
| `cloudfront_domain_name` | CloudFront domain (d\<id\>.cloudfront.net) |

## Custom domain (optional)

To use a custom domain (e.g. `www.example.com`):

1. Issue an ACM certificate in **us-east-1** (required by CloudFront).
2. Pass `certificate_arn` and `domain_aliases` into the module (root module does this when `domain_name` is set).
3. Create Route 53 alias records pointing to `cloudfront_domain_name`.
