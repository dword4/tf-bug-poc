provider "aws" {
  region = "us-east-1"
  
  default_tags {
    tags = {
      name = "itsn-proof-of-concept"
      team = "ITSN"
      managed-by = "terraform"
    }
  }
}

module "ip_sets" {
  source = "./modules/aws_wafv2_ip_set"
  ip_sets = var.ip_sets
  region = "us-east-1"
  environment = "prod"
}

module "rule_groups" {
  source = "./modules/aws_wafv2_rule_group"
  rule_groups = var.rule_groups
  ip_sets = module.ip_sets.ip_sets
  environment = "prod"
	region = "us-east-1"
  depends_on = [module.ip_sets]
}
