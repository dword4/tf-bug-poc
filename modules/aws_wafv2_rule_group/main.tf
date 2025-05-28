data "aws_wafv2_ip_set" "ip_sets" {
  for_each = var.ip_sets
  name = "${each.key}-${var.environment}"
  scope = "REGIONAL"
}

resource "aws_wafv2_rule_group" "rule_group" {
  for_each = var.rule_groups
  name     = "${each.key}-${var.environment}"
  scope    = var.region == "cloudfront" ? "CLOUDFRONT" : "REGIONAL"
  capacity = 100

  dynamic rule {
    for_each = { for k, v in each.value : k => v if try(v.statement.geo_match_statement != null, false) }

    content {
      name     = rule.value.name
      priority = rule.value.priority

      dynamic "action" {
        for_each = rule.value.action == "block" ? [1] : []
        content {
          block {}
        }
      }

      dynamic "action" {
        for_each = rule.value.action == "allow" ? [1] : []
        content {
          allow {}
        }
      }

      dynamic "action" {
        for_each = rule.value.action == "count" ? [1] : []
        content {
          count {}
        }
      }

      statement {
        geo_match_statement {
          country_codes = rule.value.statement.geo_match_statement.country_codes
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.name
        sampled_requests_enabled   = true
      }
    }
  }

  dynamic rule {
    for_each = { for k, v in each.value : k => v if try(v.statement.ip_set_reference_statement != null, false) }

    content {
      name     = rule.value.name
      priority = rule.value.priority

      dynamic "action" {
        for_each = rule.value.action == "block" ? [1] : []
        content {
          block {}
        }
      }

      dynamic "action" {
        for_each = rule.value.action == "allow" ? [1] : []
        content {
          allow {}
        }
      }

      dynamic "action" {
        for_each = rule.value.action == "count" ? [1] : []
        content {
          count {}
        }
      }

      statement {
      dynamic "or_statement" {
        for_each = length(rule.value.statement.ip_set_reference_statement) > 1 ? [1] : []
        content {
          dynamic "statement" {
            for_each = rule.value.statement.ip_set_reference_statement
            content {
              ip_set_reference_statement {
                arn = data.aws_wafv2_ip_set.ip_sets[statement.value].arn
              }
            }
          }
        }
      }

      dynamic "ip_set_reference_statement" {
        for_each = length(rule.value.statement.ip_set_reference_statement) == 1 ? [1] : []
        content {
          arn = data.aws_wafv2_ip_set.ip_sets[rule.value.statement.ip_set_reference_statement[0]].arn
        }
      }
    }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.name
        sampled_requests_enabled   = true
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = each.key
    sampled_requests_enabled   = true
  }
}

output "rule_groups" {
	value = aws_wafv2_rule_group.rule_group
}
