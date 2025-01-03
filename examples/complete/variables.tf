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

variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object(
    {
      name       = string
      max_length = optional(number, 60)
    }
  ))
  default = {
    rg = {
      name       = "rg"
      max_length = 60
    }
    sb_namespace = {
      name       = "sbn"
      max_length = 60
    }
    vnet = {
      name       = "vnet"
      max_length = 60
    }
  }
}

variable "product_family" {
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  type        = string
  default     = "dso"
}

variable "product_service" {
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  type        = string
  default     = "terratest"
}

variable "environment" {
  description = "Environment in which the resource should be provisioned like dev, qa, prod etc."
  type        = string
  default     = "dev"
}

variable "environment_number" {
  description = "The environment count for the respective environment. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "000"
}

variable "resource_number" {
  description = "The resource count for the respective resource. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "000"
}

variable "region" {
  description = "The location/region where the Service Bus Namespace should be created"
  type        = string
  default     = "eastus"
}

variable "managed_by" {
  description = "(Optional) The ID of the resource that manages this resource group."
  type        = string
  default     = null
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

variable "address_space" {
  description = "The address space used by the Virtual Network"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "A mapping of subnet names to their configurations."
  type = map(object({
    prefix = string
    delegation = optional(map(object({
      service_name    = string
      service_actions = list(string)
    })), {})
    service_endpoints                             = optional(list(string), []),
    private_endpoint_network_policies_enabled     = optional(bool, false)
    private_link_service_network_policies_enabled = optional(bool, false)
    network_security_group_id                     = optional(string, null)
    route_table_id                                = optional(string, null)
  }))
  default = {}
}

variable "servicebus_topics" {
  description = "A map of Service Bus Topics to create"
  type = map(object({
    name = string
  }))
  default = {}
}
