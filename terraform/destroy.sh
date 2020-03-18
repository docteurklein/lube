set -exuo pipefail

terraform init /terraform
terraform destroy -auto-approve -lock=false /terraform
