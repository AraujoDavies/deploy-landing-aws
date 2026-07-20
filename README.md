# Landing Page Automation

Terraform project that deploys a static landing page on AWS with **S3**, **CloudFront**, optional **Route 53**, and **ACM** (HTTPS).

## Guia de Deploy

Full step-by-step deployment docs:

- **[Português (PT-BR)](docs/deployment-guide.pt-BR.html)**
- **[English](docs/deployment-guide.html)**

> Tip: to view the guides as styled pages on GitHub, enable **Settings → Pages**, source branch `master`, folder `/docs`. Then open `…/deployment-guide.pt-BR.html` on the Pages URL.

## Quick start

```bash
terraform init
terraform plan
terraform apply
```

After apply, upload site files to the content bucket and (if needed) invalidate CloudFront — details are in the deployment guide.
