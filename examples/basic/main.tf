
module "azure_file_share" {
  source = "../.."
  name   = "example"
  file_shares = [{
    name  = "eeoc_web_files"
    quota = "20"
  }]
  tags = {
    terraform_managed = true
    delete_me         = please
  }
}

output "example_azure_file_share" {
  description = "Whole example file share resource"
  value       = module.azure_file_share
}
