module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name = local.eks_cluster_name
  cluster_version = local.eks_cluster_version
  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  enable_irsa = true

  cluster_addons = {
    coredns = {
      most_recent = true
      timeouts = {
        create = "2m"
      }
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  enable_cluster_creator_admin_permissions = true

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.nano", "t3.micro", "t3.small", "t3.medium"]
  }

  eks_managed_node_groups = {
    initial = {
      instance_types = ["t3.micro"]
      min_size = 1
      max_size = 4
      desired_size = 1

    }
  }
  
  node_security_group_additional_rules = {
    ingress_15017 = {
      description                   = "Cluster API - Istio Webhook namespace.sidecar-injector.istio.io"
      protocol                      = "TCP"
      from_port                     = 15017
      to_port                       = 15017
      type                          = "ingress"
      source_cluster_security_group = true
    }
    ingress_15012 = {
      description                   = "Cluster API to nodes ports/protocols"
      protocol                      = "TCP"
      from_port                     = 15012
      to_port                       = 15012
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }  
  tags = {
    Environment = "Development"
  }

}


