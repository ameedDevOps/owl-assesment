resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "eks-prod-vpc" }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = false
  tags = { Name = "public-${count.index}" }
}

resource "aws_subnet" "private" {
  count      = length(var.private_subnets)
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.private_subnets[count.index]
  tags = { Name = "private-${count.index}" }
}
