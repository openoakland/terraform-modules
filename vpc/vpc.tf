# VPC for Open Oakland

# Define a vpc
resource "aws_vpc" "vpc_name" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.tenancy
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.custom_tags,
  )
}

# Internet gateway for the VPC
resource "aws_internet_gateway" "public_ig" {
  vpc_id = aws_vpc.vpc_name.id
  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.custom_tags,
  )
}

# Get a list of Availability Zones in the current region
data "aws_availability_zones" "available" {
}

# Public subnet
resource "aws_subnet" "vpc_public_sn" {
  count  = data.template_file.num_availability_zones.rendered
  vpc_id = aws_vpc.vpc_name.id
  cidr_block = lookup(
    var.vpc_public_subnet_cidr,
    "AZ-${count.index}",
    cidrsubnet(var.vpc_cidr_block, 5, count.index),
  )
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = merge(
    {
      "Name" = "${var.vpc_name}-public-${count.index}"
    },
    var.custom_tags,
  )
}

# Routing table for public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_name.id
  tags = merge(
    {
      "Name" = "${var.vpc_name}-public"
    },
    var.custom_tags,
  )
}

resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.public_ig.id

  depends_on = [
    aws_internet_gateway.public_ig,
    aws_route_table.public_rt,
  ]

  timeouts {
    create = "5m"
  }
}

# Associate the routing table to public subnet
resource "aws_route_table_association" "public_rt" {
  count          = data.template_file.num_availability_zones.rendered
  subnet_id      = element(aws_subnet.vpc_public_sn.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# NAT Gateway
resource "aws_eip" "nat_gw" {
  count      = var.num_nat_gateways
  vpc        = true
  depends_on = [aws_internet_gateway.public_ig]
}

resource "aws_nat_gateway" "nat_gw" {
  count         = var.num_nat_gateways
  allocation_id = element(aws_eip.nat_gw.*.id, count.index)
  subnet_id     = element(aws_subnet.vpc_public_sn.*.id, count.index)

  # As recommended by the Terraform docs
  depends_on = [aws_internet_gateway.public_ig]
}

# Private subnet
resource "aws_subnet" "vpc_private_sn" {
  count  = data.template_file.num_availability_zones.rendered
  vpc_id = aws_vpc.vpc_name.id
  cidr_block = lookup(
    var.vpc_private_subnet_cidr,
    "AZ-${count.index}",
    cidrsubnet(var.vpc_cidr_block, 5, count.index),
  )
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = merge(
    {
      "Name" = "${var.vpc_name}-private-${count.index}"
    },
    var.custom_tags,
  )
}

# Create a Route Table for each private subnet
resource "aws_route_table" "private_rt" {
  count            = data.template_file.num_availability_zones.rendered
  vpc_id           = aws_vpc.vpc_name.id
  propagating_vgws = var.private_propagating_vgws
  tags = merge(
    {
      "Name" = "${var.vpc_name}-private-${count.index}"
    },
    var.custom_tags,
  )
}

# Create a route for outbound Internet traffic.
resource "aws_route" "nat" {
  count                  = var.num_nat_gateways == 0 ? 0 : data.template_file.num_availability_zones.rendered
  route_table_id         = element(aws_route_table.private_rt.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat_gw.*.id, count.index)

  depends_on = [
    aws_internet_gateway.public_ig,
    aws_route_table.private_rt,
  ]

  timeouts {
    create = "5m"
  }
}

# Associate each private-app subnet with its respective route table
resource "aws_route_table_association" "private_rt" {
  count          = data.template_file.num_availability_zones.rendered
  subnet_id      = element(aws_subnet.vpc_private_sn.*.id, count.index)
  route_table_id = element(aws_route_table.private_rt.*.id, count.index)
}

data "template_file" "num_availability_zones" {
  template = var.num_availability_zones == -1 ? length(data.aws_availability_zones.available.names) : var.num_availability_zones
}

