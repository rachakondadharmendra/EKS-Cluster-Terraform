variable "EKS_Cluster_Region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "EKS_Cluster_Name" {
  description = "Cluster Name"
  type = string
  default = "EKS-Cluster"
}

variable "EKS_Cluster_VPC_Name" {
  description = "VPC Name"
  type = string
  default = "EKS-Cluster-VPC"
}  