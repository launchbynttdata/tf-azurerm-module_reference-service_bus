// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "resource_group_name" {
  description = "The name of the Resource Group in which the Service Bus Namespace should be created"
  type        = string
}

variable "namespace_name" {
  description = "The name of the Service Bus Namespace"
  type        = string
}

variable "region" {
  description = "The location/region where the Service Bus Namespace should be created"
  type        = string
}

variable "sku" {
  description = "The SKU of the Service Bus Namespace"
  type        = string
  default     = "Standard"
}

variable "configure_identity" {
  description = "Should the identity be configured"
  type        = bool
  default     = true
}

variable "identity_type" {
  description = "The type of identity used for the Service Bus Namespace"
  type        = string
  default     = "SystemAssigned"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "capacity" {
  description = "The capacity of the Service Bus Namespace"
  type        = number
  default     = 0
}

variable "identity_ids" {
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned"
  type        = list(string)
  default     = []
}

variable "minimum_tls_version" {
  description = "The minimum TLS version"
  type        = string
  default     = "1.2"
}

variable "public_network_access_enabled" {
  description = "Is public network access enabled"
  type        = bool
  default     = true
}

variable "network_rule_set" {
  description = "The Network Rule Set for the Service Bus Namespace"
  type = object({
    default_action                = optional(string, "Allow")
    public_network_access_enabled = optional(bool, true)
    trusted_services_allowed      = optional(bool)
    ip_rules                      = optional(list(string))
  })
  default = null
}

variable "network_rules" {
  description = "The Network Rules for the Service Bus Namespace"
  type = list(object({
    subnet_id                            = string
    ignore_missing_vnet_service_endpoint = optional(bool, false)
  }))
  default = []
}

variable "premium_messaging_partitions" {
  description = "The number of partitions for Premium Messaging"
  type        = number
  default     = 0
}

variable "local_auth_enabled" {
  description = "Is local authentication enabled"
  type        = bool
  default     = true
}

variable "servicebus_topics" {
  description = "A map of Service Bus Topics to create"
  type = map(object({
    name = string
  }))
  default = {}
}
