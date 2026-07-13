---
name: project-portfolio-terraform-baseline
description: Baseline state of terraform/ (S3+CloudFront static site) as of 2026-07-13 audit — what's solid vs. recurring gaps
metadata:
  type: project
---

The `terraform/` directory (providers.tf, variables.tf, main.tf, outputs.tf, backend.tf) provisions
an S3 + CloudFront static site (the portfolio at repo root: index.html/style.css, no JS, no build step).

**Already solid (don't re-flag as findings unless changed):**
- `aws_s3_bucket_public_access_block` on the site bucket blocks all public access.
- Uses CloudFront OAC (`aws_cloudfront_origin_access_control`), not legacy OAI.
- Bucket policy is scoped with an `AWS:SourceArn` condition tied to the specific CloudFront distribution ARN — good least-privilege pattern.
- `object_ownership = "BucketOwnerEnforced"` — no ACLs used at all.
- `default_cache_behavior.viewer_protocol_policy = "redirect-to-https"`.
- No hardcoded ARNs/account IDs/credentials anywhere in these files.
- `aws_s3_bucket_policy` has `depends_on` the public access block (correct ordering).
- No IAM roles/policies or OIDC trust resources exist in this terraform/ at all — the IAM/OIDC/wildcard
  checklist items are simply N/A for this repo unless a workflow-deploy IAM role is added later (check
  `.github/workflows/` if that ever appears).

**Recurring gaps found in the 2026-07-13 audit (check whether still unresolved on next audit):**
- No `aws_s3_bucket_server_side_encryption_configuration` on the site bucket (no SSE at rest).
- No `aws_s3_bucket_versioning` on the site bucket.
- No CloudFront `logging_config` block (no access logs).
- No `aws_cloudfront_response_headers_policy` attached — missing CSP/X-Frame-Options/HSTS/etc.
- `viewer_certificate` always hardcodes `cloudfront_default_certificate = true`, even though
  `aliases` conditionally includes `var.domain_name`. If a custom domain is ever set, this breaks
  (CloudFront requires an ACM cert for aliases) — watch for whether an ACM cert resource/data source
  and conditional `acm_certificate_arn` + `minimum_protocol_version` get added.
- `backend.tf` intentionally ships with the S3 backend commented out (documented bootstrap
  instructions inside the file) — local state is the current default. The example backend uses
  `use_lockfile` (needs Terraform >=1.10) but `required_version` in providers.tf is only `>= 1.5`.
- No WAFv2 Web ACL attached to the distribution (optional/low priority for a static portfolio site).

**Why this matters:** this is a small, mostly well-written student/cohort project (DMI Cohort 3,
Saima Usman) — the baseline is already good, so audits should focus on the delta above rather than
re-deriving the whole checklist from scratch each time.
