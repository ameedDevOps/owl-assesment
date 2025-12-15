resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "prod-ng"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = aws_subnet.private[*].id

  scaling_config {
    min_size     = 2
    desired_size = 3
    max_size     = 5
  }

  instance_types = ["t3.large"]
  disk_size      = 50
}
