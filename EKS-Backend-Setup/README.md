# AWS EKS Backend Configuration

This folder outlines the process of configuring a remote backend for Terraform state files with state locking, specifically tailored for Amazon Elastic Kubernetes Service (EKS) deployments.

## Folder Structure

- The `variables.tf` file is available for defining variables.
.
├── main.tf
├── modules
│   ├── dynamodb_table
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── s3_bucket
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── outputs.tf
