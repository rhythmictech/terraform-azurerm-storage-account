
output "storage_account" {
  description = "Storage Account Resource"
  value       = azurerm_storage_account.this
}

output "storage_containers" {
  description = "Storage Container Resource"
  value       = azurerm_storage_container.this
}

output "storage_blobs" {
  description = "Storage blob Resource"
  value       = azurerm_storage_blob.this
}

output "storage_shares" {
  description = "Storage share Resource"
  value       = azurerm_storage_share.this
}
