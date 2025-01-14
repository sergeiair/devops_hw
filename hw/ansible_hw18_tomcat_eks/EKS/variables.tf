variable "region" {
  description = "AWS region to deploy the cluster"
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Availability Zone for subnets"
  default     = "us-east-1a"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "sergeis-cluster"
}

variable "node_group_name" {
  description = "Name of the EKS Node Group"
  default     = "sergeis-node-group"
}

variable "desired_size" {
  description = "Desired number of nodes in the EKS Node Group"
  default     = 1
}

variable "min_size" {
  description = "Minimum number of nodes in the EKS Node Group"
  default     = 1
}

variable "max_size" {
  description = "Maximum number of nodes in the EKS Node Group"
  default     = 3
}

variable "key_name" {
  description = "Key name"
  default     = "devops"
}
