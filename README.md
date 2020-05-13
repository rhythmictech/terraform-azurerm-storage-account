# Storage Account [![](https://github.com/rhythmictech/terraform-azurerm-storage-account/workflows/check/badge.svg)](https://github.com/rhythmictech/terraform-azurerm-storage-account/actions) <a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=RhythmicTech" alt="follow on Twitter"></a>
Terraform module for managing Azure storage accounts and their sub-resources

## Example
To create a single fileshare with 20 GB of space:
```
module "azure_file_share" {
  source  = "rhythmictech/storage-account/azurerm"
  version = "1.0.0-alpha"

  name   = "example"
  file_shares = [{
    name  = "my_example_fileshare"
    quota = "20"
  }]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_kind | Storage account kind | `string` | `"StorageV2"` | no |
| account\_replication\_type | Storage account replication type | `string` | `"LRS"` | no |
| account\_tier | Storage account tier | `string` | `"Standard"` | no |
| create\_resource\_group | Boolean to create resource group (default) or not | `bool` | `true` | no |
| file\_shares | List of storage share definitions | `list(map(any))` | `[]` | no |
| location | Primary region used for project | `string` | `"eastus"` | no |
| name | Moniker to apply to resources | `string` | n/a | yes |
| network\_rules | Storage account network rules, docs.microsoft.com/en-gb/azure/storage/common/storage-network-security | <pre>object({<br>    default_action             = string<br>    bypass                     = list(string)<br>    ip_rules                   = list(string)<br>    virtual_network_subnet_ids = list(string)<br>  })</pre> | <pre>{<br>  "bypass": [<br>    "None"<br>  ],<br>  "default_action": "Allow",<br>  "ip_rules": [],<br>  "virtual_network_subnet_ids": []<br>}</pre> | no |
| resource\_group\_name | defaults to '${var.name}-rg' | `string` | `""` | no |
| storage\_account\_name | defaults to  'lower(replace(var.name, /[^0-9A-Za-z]/, ''))'' | `string` | `""` | no |
| storage\_blobs | List of storage blob definitions | `list(map(string))` | `[]` | no |
| storage\_containers | List of storage container definitions | `list(map(string))` | `[]` | no |
| tags | Tags to apply to resources | `map(string)` | <pre>{<br>  "terraform_managed": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| storage\_account | Storage Account Resource |
| storage\_blobs | Storage blob Resource |
| storage\_containers | Storage Container Resource |
| storage\_shrares | Storage share Resource |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
