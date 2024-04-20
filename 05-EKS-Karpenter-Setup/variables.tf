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

### Add-ons
variable "version_kube_proxy" {
  description = "Versão do Kube-Proxy"
  type        = string
  default     = "v1.29.3-eksbuild.2"
}

variable "version_coredns" {
  description = "Versão do Coredns"
  type        = string
  default     = "v1.11.1-eksbuild.6"
}

variable "version_vpc-cni" {
  description = "Versão do VPC-CNI"
  type        = string
  default     = "v1.18.0-eksbuild.1"
}

variable "version_ebs-csi" {
  description = "Versão do EBS-CSI"
  type        = string
  default     = "v1.29.1-eksbuild.1"
}