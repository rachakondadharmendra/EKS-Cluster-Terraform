output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "EKS_Cluster_Region" {
  description = "AWS region"
  value       = var.EKS_Cluster_Region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "EKS_Cluster_VPC" {
  description = "AWS region"
  value       = var.EKS_Cluster_VPC_Name
}
