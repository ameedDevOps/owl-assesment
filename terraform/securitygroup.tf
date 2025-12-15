resource "aws_security_group" "eks_cp" {
  name        = "eks-control-plane-sg"
  description = "EKS control plane SG"
  vpc_id      = aws_vpc.eks_vpc.id

  ingress {
    description = "API access from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Outbound inside VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.eks_vpc.id
  ingress = []
  egress  = []
}
