output "vpc_id" {
  value = aws_vpc.vpc_name.id
}

output "num_availability_zones" {
  value = var.num_availability_zones == -1 ? length(data.aws_availability_zones.available.names) : var.num_availability_zones
}

output "availability_zones" {
  value = [slice(
    data.aws_availability_zones.available.names,
    0,
    data.template_file.num_availability_zones.rendered,
  )]
}

output "vpc_public_sn_id" {
  value = [aws_subnet.vpc_public_sn.*.id]
}

output "vpc_private_sn_id" {
  value = [aws_subnet.vpc_private_sn.*.id]
}

