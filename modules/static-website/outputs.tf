output "content_bucket_name" {
  description = "Name of the S3 content bucket"
  value       = aws_s3_bucket.content.id
}

output "content_bucket_arn" {
  description = "ARN of the S3 content bucket"
  value       = aws_s3_bucket.content.arn
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.main.id
}

output "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.main.arn
}

output "cloudfront_domain_name" {
  description = "Public domain name of the CloudFront distribution (e.g. d1234abcd.cloudfront.net)"
  value       = aws_cloudfront_distribution.main.domain_name
}

output "website_url" {
  description = "Full HTTPS URL of the static website"
  value       = "https://${aws_cloudfront_distribution.main.domain_name}"
}
