provider "azurerm" {
  version = "~> 1.43.0"
}

module "azure_file_share" {
  source = "../.."
  name   = "example"
  file_shares = [{
    name  = "my_example_fileshare"
    quota = "20"
  }]
}

output "example_azure_file_share" {
  description = "Whole example file share resource"
  value       = module.azure_file_share
}
