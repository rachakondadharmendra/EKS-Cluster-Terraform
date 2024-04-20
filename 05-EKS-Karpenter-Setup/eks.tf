module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name = local.eks_cluster_name
  cluster_version = local.eks_cluster_version
  cluster_endpoint_public_access = true
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets
  enable_irsa = true
  create_node_security_group = false

  enable_cluster_creator_admin_permissions = true

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.nano", "t3.micro", "t3.small", "t3.medium"]
  }

  eks_managed_node_groups = {
    initial = {
      instance_types = ["t3.medium"]
      min_size = 1
      max_size = 4
      desired_size = 1
      subnet_ids = module.vpc.private_subnets
    }
    two = {
      name = "node-group-2"
      instance_types = ["t3.small"]
      min_size     = 2
      max_size     = 2
      desired_size = 2  
      subnet_ids = module.vpc.private_subnets
    }    
  }
  
  tags = {
    Environment = "Development"
    "karpenter.sh/discovery" = var.EKS_Cluster_Name
  }

}
module "kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=blueprints-workshops/modules/kubernetes-addons"

  eks_cluster_id     = module.eks.cluster_name

  enable_amazon_eks_coredns = true
  enable_amazon_eks_kube_proxy = true
  enable_amazon_eks_vpc_cni = true      
  enable_amazon_eks_aws_ebs_csi_driver = true

  enable_aws_load_balancer_controller        = true
  enable_aws_for_fluentbit                   = true
  enable_metrics_server                      = true
  enable_karpenter                           = true                                       # <-- Add this line 
  karpenter_enable_spot_termination_handling = true                                 # <-- Add this line 

}




