terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.13.0"
    }    
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5" 
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }
  }

  required_version = "~> 1.3"
}