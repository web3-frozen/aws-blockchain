# VPC and Subnet
resource "aws_vpc" "cronos_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "cronos-vpc"
  }
}

resource "aws_subnet" "cronos_subnet" {
  vpc_id            = aws_vpc.cronos_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "cronos-subnet"
  }
}

resource "aws_internet_gateway" "cronos_igw" {
  vpc_id = aws_vpc.cronos_vpc.id
  tags = {
    Name = "cronos-igw"
  }
}

resource "aws_route_table" "cronos_rt" {
  vpc_id = aws_vpc.cronos_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cronos_igw.id
  }
  tags = {
    Name = "cronos-rt"
  }
}

resource "aws_route_table_association" "cronos_rta" {
  subnet_id      = aws_subnet.cronos_subnet.id
  route_table_id = aws_route_table.cronos_rt.id
}