provider "aws" {
  region = var.EKS_Cluster_Region
}

locals {
  cluster_name = var.EKS_Cluster_Name
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name = var.EKS_Cluster_Name
  cluster_version = "1.29"
  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  enable_irsa = true

  eks_managed_node_groups = {
    general_instance = {
      name = "Node-Group-1"
      instance_types = ["t3.micro"]
      capacity_type = "ON_DEMAND"
      min_size = 1
      max_size = 4
      desired_size = 1
      labels = {
        role = "general"
      }
    }

    spot_instance = {
      name = "Node-Group-2"
      instance_types = ["t3.micro"]
      capacity_type = "SPOT"
      min_size = 1
      max_size = 4
      desired_size = 2
      labels = {
        role = "general"
      }
    }
  }

  tags = {
    Environment = "Development"
  }

  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = module.eks_admin_role.iam_role_arn
      username = module.eks_admin_role.iam_role_name
      groups   = ["system:masters"]
    },
  ]

}

data "aws_eks_cluster" "default" {
  name = module.eks.cluster_name
  depends_on = [
    module.eks.eks_managed_node_groups,
  ]  
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_name
  depends_on = [
    module.eks.eks_managed_node_groups,
  ]  
}

provider "kubernetes" {
  host = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.name]
    command = "aws"
  }
}