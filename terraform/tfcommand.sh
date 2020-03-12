set -exuo pipefail

terraform init /terraform
terraform plan -lock=false /terraform

kubectl create configmap terraform --from-file /terraform -o yaml --dry-run | kubectl replace -f -
