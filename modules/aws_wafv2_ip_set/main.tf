resource "aws_wafv2_ip_set" "ip_sets" {
  for_each = var.ip_sets
  name = "${each.key}-${var.environment}"
  description = "FMS IP Set"
  scope = "REGIONAL"
  ip_address_version = "IPV4"
  addresses = each.value
}

output "ip_sets" {
  value = aws_wafv2_ip_set.ip_sets
}
