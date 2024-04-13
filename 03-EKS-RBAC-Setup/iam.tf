# Module for managing access policies for EKS administration
module "eks_admin_access_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.38.0"

  name          = "eks_admin_access_policy"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Module for managing IAM role for EKS administration
module "eks_admin_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.38.0"

  role_name         = "eks_admin_role"
  create_role       = true
  role_requires_mfa = false

  custom_role_policy_arns = [module.eks_admin_access_policy.arn]

  trusted_role_arns = [
    "arn:aws:iam::${module.vpc.vpc_owner_id}:root"
  ]
}

# Module for managing IAM user for EKS administration
module "eks_admin_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.38.0"

  name                          = "eks_admin_user"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}

# Module for allowing EKS admin policy
module "allow_eks_admin_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.38.0"

  name          = "allow_eks_admin_role"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = module.eks_admin_role.iam_role_arn
      },
    ]
  })
}

# Module for managing IAM group for EKS administration
module "eks_admin_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.38.0"

  name                              = "eks_admin_group"
  attach_iam_self_management_policy = false
  create_group                      = true
  group_users                       = [module.eks_admin_user.iam_user_name]
  custom_group_policy_arns          = [module.allow_eks_admin_policy.arn]
}

