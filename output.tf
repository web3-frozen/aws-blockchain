output "instance_public_ip" {
  value = aws_eip.cronos_eip.public_ip
}