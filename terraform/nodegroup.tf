resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "default-ng"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = aws_subnet.private[*].id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  disk_size = 20

  labels = {
    environment = "demo"
  }
}
