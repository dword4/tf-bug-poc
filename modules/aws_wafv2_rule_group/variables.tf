variable "environment" {
  description = "Account Environment (nonprod/prod) to deploy to"
  type        = string
}

variable "ip_sets" {
  description = "Map of IP sets to create"
  type        = map
}

variable "region" {
  description = "The region to deploy the WAFv2 IP set"
  type        = string
}

variable "rule_groups" {
  description = "Map of IP sets to create"
  type        = map
  default     = {}
}
