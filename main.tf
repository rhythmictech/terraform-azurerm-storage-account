
########################################
# General
########################################
terraform {
  required_version = ">= 0.12"
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}

########################################
# General
########################################
resource "azurerm_storage_account" "this" {
  name                     = local.storage_account_name
  tags                     = var.tags
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = var.account_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type

  network_rules {
    default_action             = var.network_rules.default_action
    bypass                     = var.network_rules.bypass
    ip_rules                   = var.network_rules.ip_rules
    virtual_network_subnet_ids = var.network_rules.virtual_network_subnet_ids
  }
}

resource "azurerm_storage_container" "this" {
  count = length(var.storage_containers)

  name                  = lower(lookup(var.storage_containers[count.index], "name", "container${count.index}"))
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = lookup(var.storage_containers[count.index], "container_access_type", "private")
}

resource "azurerm_storage_blob" "this" {
  count = length(var.storage_blobs)

  name                   = lookup(var.storage_blobs[count.index], "name", "blob${count.index}")
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = lookup(var.storage_blobs[count.index], "storage_container_name")
  type                   = lookup(var.storage_blobs[count.index], "type", "Block")
}

resource "azurerm_storage_share" "this" {
  count = length(var.file_shares)

  name                 = lower(replace(lookup(var.file_shares[count.index], "name", "fileshare${count.index}"), "/[^0-9A-Za-z]/", ""))
  storage_account_name = azurerm_storage_account.this.name
  quota                = lookup(var.file_shares[count.index], "quota", null)

  # TODO(sblack4): make this work
  # metadata             = lookup(var.file_shares[count.index], "metadata", {})

  # dynamic "acl" {
  #   for_each = lookup(var.file_shares[count.index], "acl", [])

  #   content {
  #     id = lookup(var.file_shares[count.index].acl, "id", "acl${count.index}")

  #     access_policy {
  #       expiry      = lookup(var.file_shares[count.index].acl, "expiry")
  #       permissions = lookup(var.file_shares[count.index].acl, "permissions")
  #       start       = lookup(var.file_shares[count.index].acl, "start")
  #     }
  #   }
  # }
}
