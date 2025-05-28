variable "environment" {
  description = "Account Environment (nonprod/prod) to deploy to"
  type        = string
  default     = null
}

variable "ip_sets" {
  description = "Map of IP sets to deploy"
  type        = map
  default     = {}
}

variable "region" {
  description = "Region to deploy FMS resources"
  type        = string
}
variable "rule_groups" {
  description = "Map of IP sets to create"
  type        = map
  default     = {}
}
