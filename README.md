# Storage Account

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_kind | Storage account kind | string | `"StorageV2"` | no |
| account\_replication\_type | Storage account replication type | string | `"LRS"` | no |
| account\_tier | Storage account tier | string | `"Standard"` | no |
| file\_shares | List of storage share definitions | list(map(any)) | `[]` | no |
| name | Moniker to apply to resources | string | n/a | yes |
| network\_rules | Storage account network rules, docs.microsoft.com/en-gb/azure/storage/common/storage-network-security | object | `{ "bypass": [ "None" ], "default_action": "Allow", "ip_rules": [], "virtual_network_subnet_ids": [] }` | no |
| storage\_blobs | List of storage blob definitions | list(map(string)) | `[]` | no |
| storage\_containers | List of storage container definitions | list(map(string)) | `[]` | no |

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
