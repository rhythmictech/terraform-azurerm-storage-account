# =============================================
# variables
# =============================================

variable "name" {
  description = "Moniker to apply to resources"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "account_kind" {
  description = "Storage account kind"
  type        = string
  default     = "StorageV2"
}

variable "account_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
}

variable "network_rules" {
  description = "Storage account network rules, docs.microsoft.com/en-gb/azure/storage/common/storage-network-security"
  type = object({
    default_action             = string
    bypass                     = list(string)
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  default = {
    default_action             = "Allow"
    bypass                     = ["None"]
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}

variable "storage_containers" {
  description = "List of storage container definitions"
  type        = list(map(string))
  default     = []
}

variable "storage_blobs" {
  description = "List of storage blob definitions"
  type        = list(map(string))
  default     = []
}

variable "file_shares" {
  description = "List of storage share definitions"
  type        = list(map(any))
  default     = []
}
