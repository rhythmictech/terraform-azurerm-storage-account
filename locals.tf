
locals {
  resource_group_name  = coalesce(var.resource_group_name, "${var.name}-RG")
  storage_account_name = coalesce(var.storage_account_name, lower(replace(var.name, "/[^0-9A-Za-z]/", "")))
}
