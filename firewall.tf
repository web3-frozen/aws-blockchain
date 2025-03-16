resource "aws_security_group" "cronos_sg" {
  vpc_id = aws_vpc.cronos_vpc.id

  # SSH access (unchanged)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.whitelisted_ips
  }

  # Nginx access
  ingress {
    from_port   = 8000
    to_port     = 8001
    protocol    = "tcp"
    cidr_blocks = var.whitelisted_ips
  }

  # Tendermint RPC (VPC-internal)
  ingress {
    from_port   = 26657
    to_port     = 26657
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # REST API (VPC-internal)
  ingress {
    from_port   = 1317
    to_port     = 1317
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # P2P port
  ingress {
    from_port   = 26656
    to_port     = 26656
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all peers to connect
  }

  # Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cronos-sg"
  }
}