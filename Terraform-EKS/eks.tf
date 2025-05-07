module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = local.name
  cluster_version = "1.31"

#   # Optional
#   cluster_endpoint_public_access = true

#   # Optional: Adds the current caller identity as an administrator via cluster access entry
#   enable_cluster_creator_admin_permissions = true

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

    vpc_id     = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets
    control_plane_subnet_ids = module.vpc.intra_subnets
    cluster_addons = {
        vpc-cni={
            most-recent=true
        }
        kube-proxy={
            most-recent=true
        }
        core-dns={
            most-recent=true
        }
    eks_managed_node_group_defaults = {
        instance_types = local.instance_type
    }

  eks_managed_node_groups = {
    tws-cluster-ng = {
      instance_types = local.instance_type

      min_size     = 2
      max_size     = 3
      desired_size = 2
      capacity_type="SPOT"
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
}