# variables.tf
variable "whitelisted_ips" {
  description = "List of IP addresses or CIDR blocks allowed for SSH access"
  type        = list(string)
  sensitive   = true
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair in AWS"
  type        = string
  sensitive   = true
}