
resource "azurerm_monitor_metric_alert" "storage_account" {
  for_each            = var.storage_account_monitor_metric_alert_criteria
  name                = "${var.name}-${upper(each.key)}"
  resource_group_name = azurerm_resource_group.this.id
  scopes              = azurerm_storage_account.this.id
  tags                = var.tags

  action {
    action_group_id = var.storage_account_monitor_action_group_id
  }

  # see https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported
  criteria {
    aggregation      = each.value.aggregation
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = each.value.metric_name
    operator         = each.value.operator
    threshold        = each.value.threshold

    dimension {
      name     = each.value.dimension.name
      operator = each.value.dimension.operator
      values   = each.value.dimension.values
    }
  }
}
