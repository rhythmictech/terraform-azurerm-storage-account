########################################
# General Variables
########################################
variable "name" {
  description = "Moniker to apply to resources"
  type        = string
}

variable "location" {
  description = "Primary region used for project"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    terraform_managed = true
  }
}

variable "create_resource_group" {
  description = "Boolean to create resource group (default) or not"
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "defaults to '$${var.name}-rg'"
  type        = string
  default     = ""
}

########################################
# Storage Account Variables
########################################
variable "storage_account_name" {
  description = "defaults to  'lower(replace(var.name, /[^0-9A-Za-z]/, ''))''"
  type        = string
  default     = ""
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

########################################
# SA sub-resource Variables
########################################
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

########################################
# Monitoring
########################################
variable "storage_account_monitor_action_group_id" {
  default     = ""
  description = "ID of Azure Monitor Action Group for metric to trigger"
  type        = string
}

variable "storage_account_monitor_metric_alert_criteria" {
  default     = {}
  description = "Map of name = criteria objects"
  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    metric_name = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number
  }))
}
