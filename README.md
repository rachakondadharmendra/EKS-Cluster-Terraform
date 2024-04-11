
## Initialize Terraform
terraform init

## Terraform Validate
terraform validate

## Terraform Plan to Verify what it is going to create / update / destroy
terraform plan

## Terraform Apply to create resources
terraform apply 
[or]
terraform apply -auto-approve

## Terraform Destroy
terraform destroy
[or]
terraform plan -destroy  # You can view destroy plan using this command
terraform destroy

## Delete Terraform files 
rm -rf .terraform*
rm -rf terraform.tfstate*


## Commands to configure the cluster locally and connect to it / verify it
aws eks update-kubeconfig \
 --region $(terraform output -raw region) \
 --name $(terraform output -raw cluster_name)

kubectl cluster-info
kubectl get nodes
