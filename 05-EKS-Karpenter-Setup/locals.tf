locals {
  vpc_name            = var.EKS_Cluster_VPC_Name
  vpc_cidr            = "10.0.0.0/16"
  eks_cluster_name    = var.EKS_Cluster_Name
  eks_cluster_version = "1.29"
  region              = var.EKS_Cluster_Region
  istio_chart_url     = "https://istio-release.storage.googleapis.com/charts"
  istio_chart_version = "1.21.1"

}

