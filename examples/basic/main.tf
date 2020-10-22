provider "azurerm" {
  version = "~> 1.43.0"
}

resource "random_pet" "unique_name" {}

locals {
  unique_storage_account_name = random_pet.unique_name.id
}

module "azure_file_share" {
  source                = "../.."
  name                  = local.unique_storage_account_name
  create_recovery_vault = true
  file_shares = [{
    name  = "my_example_fileshare"
    quota = "20"
  }]
  file_share_backup_policy = {
    time  = "04:00"
    count = 60
  }
}

output "example_azure_file_share" {
  description = "Whole example file share resource"
  value       = module.azure_file_share
}
