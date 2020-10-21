
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
}

########################################
# Recovery
########################################

resource "azurerm_recovery_services_vault" "this" {
  count               = var.create_recovery_vault ? 1 : 0
  name                = "${var.name}-recovery-vault"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_backup_container_storage_account" "this" {
  count               = var.create_recovery_vault ? 1 : 0
  resource_group_name = azurerm_resource_group.this.name
  recovery_vault_name = try(azurerm_recovery_services_vault.this[0].name, null)
  storage_account_id  = azurerm_storage_account.this.id
}

resource "azurerm_backup_policy_file_share" "this" {
  count               = var.create_recovery_vault ? 1 : 0
  name                = "${var.name}-recovery-vault-policy"
  resource_group_name = azurerm_resource_group.this.name
  recovery_vault_name = try(azurerm_recovery_services_vault.this[0].name, null)

  backup {
    frequency = "Daily"
    time      = var.file_share_backup_policy.time
  }
  retention_daily {
    count = var.file_share_backup_policy.count
  }
}

resource "azurerm_backup_protected_file_share" "this" {
  count                     = var.create_recovery_vault ? length(azurerm_storage_share.this[*]) : 0
  resource_group_name       = azurerm_resource_group.this.name
  recovery_vault_name       = try(azurerm_recovery_services_vault.this[0].name, null)
  source_storage_account_id = try(azurerm_backup_container_storage_account.this[0].storage_account_id, null)
  source_file_share_name    = try(azurerm_storage_share.this[count.index].name, null)
  backup_policy_id          = try(azurerm_backup_policy_file_share.this[0].id, null)
}
