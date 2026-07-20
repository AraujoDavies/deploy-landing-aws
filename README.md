# Landing Page Automation

Terraform project that deploys a static landing page on AWS with **S3**, **CloudFront**, optional **Route 53**, and **ACM** (HTTPS).

## Guia de Deploy

Full step-by-step deployment docs (GitHub Pages):

- **[Português (PT-BR)](https://araujodavies.github.io/deploy-landing-aws/deployment-guide.pt-BR.html)**
- **[English](https://araujodavies.github.io/deploy-landing-aws/deployment-guide.html)**

## Quick start

```bash
terraform init
terraform plan
terraform apply
```

After apply, upload site files to the content bucket and (if needed) invalidate CloudFront — details are in the deployment guide.
