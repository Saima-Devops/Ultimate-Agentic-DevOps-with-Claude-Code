# ---------------------------------------------------------------------------
# Remote state backend (S3)
# ---------------------------------------------------------------------------
#
# The backend is commented out intentionally. Follow this order:
#
#   1. First run `terraform init` WITHOUT this backend (local state), then
#      `terraform apply` to create your infrastructure. If you want a
#      dedicated state bucket, create one first (it must be globally unique):
#
#        aws s3api create-bucket \
#          --bucket portfolio-site-tfstate \
#          --region ap-south-1 \
#          --create-bucket-configuration LocationConstraint=ap-south-1
#        aws s3api put-bucket-versioning \
#          --bucket portfolio-site-tfstate \
#          --versioning-configuration Status=Enabled
#
#   2. Uncomment the block below and fill in your bucket name.
#
#   3. Migrate your existing local state to the S3 backend:
#
#        terraform init -migrate-state
#
# ---------------------------------------------------------------------------

# terraform {
#   backend "s3" {
#     bucket       = "portfolio-site-tfstate"
#     key          = "portfolio-site/terraform.tfstate"
#     region       = "ap-south-1"
#     encrypt      = true
#     use_lockfile = true
#   }
# }
