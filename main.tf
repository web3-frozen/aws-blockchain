# EC2 Instance
data "aws_ami" "debian" {
  most_recent = true
  owners      = ["136693071363"]  # Official Debian AWS account

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "cronos_node" {
  ami                    = data.aws_ami.debian.id  # Latest Debian 12 AMI
  instance_type          = "t3.large"
  subnet_id              = aws_subnet.cronos_subnet.id
  vpc_security_group_ids = [aws_security_group.cronos_sg.id]
  key_name               = var.ssh_key_name
  associate_public_ip_address = true
  tags = { Name = "cronos-observer-node" }
  root_block_device {
    volume_size = 30  # Size in GB
    volume_type = "gp3"  # General Purpose SSD
    delete_on_termination = true  # Delete volume when instance is terminated
  }
}

# Elastic IP
resource "aws_eip" "cronos_eip" {
  instance = aws_instance.cronos_node.id
  tags     = { Name = "cronos-observer-eip" }
}

# EBS Volume for Persistence
resource "aws_ebs_volume" "cronos_data" {
  availability_zone = "us-east-1a"
  size              = 100
  tags = {
    Name = "cronos-data"
  }
}

resource "aws_volume_attachment" "cronos_data_attachment" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.cronos_data.id
  instance_id = aws_instance.cronos_node.id
}