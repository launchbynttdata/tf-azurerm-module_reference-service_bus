# complete

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.0 |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | terraform.registry.launch.nttdata.com/module_primitive/virtual_network/azurerm | ~> 3.0 |
| <a name="module_servicebus"></a> [servicebus](#module\_servicebus) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object(<br>    {<br>      name       = string<br>      max_length = optional(number, 60)<br>    }<br>  ))</pre> | <pre>{<br>  "rg": {<br>    "max_length": 60,<br>    "name": "rg"<br>  },<br>  "sb_namespace": {<br>    "max_length": 60,<br>    "name": "sbn"<br>  },<br>  "vnet": {<br>    "max_length": 60,<br>    "name": "vnet"<br>  }<br>}</pre> | no |
| <a name="input_product_family"></a> [product\_family](#input\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"dso"` | no |
| <a name="input_product_service"></a> [product\_service](#input\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"terratest"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_region"></a> [region](#input\_region) | The location/region where the Service Bus Namespace should be created | `string` | `"eastus"` | no |
| <a name="input_managed_by"></a> [managed\_by](#input\_managed\_by) | (Optional) The ID of the resource that manages this resource group. | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the Service Bus Namespace | `string` | `"Standard"` | no |
| <a name="input_configure_identity"></a> [configure\_identity](#input\_configure\_identity) | Should the identity be configured | `bool` | `true` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of identity used for the Service Bus Namespace | `string` | `"SystemAssigned"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The capacity of the Service Bus Namespace | `number` | `0` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of User Assigned Managed Identity IDs to be assigned | `list(string)` | `[]` | no |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The minimum TLS version | `string` | `"1.2"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Is public network access enabled | `bool` | `true` | no |
| <a name="input_network_rule_set"></a> [network\_rule\_set](#input\_network\_rule\_set) | The Network Rule Set for the Service Bus Namespace | <pre>object({<br>    default_action                = optional(string, "Allow")<br>    public_network_access_enabled = optional(bool, true)<br>    trusted_services_allowed      = optional(bool)<br>    ip_rules                      = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | The Network Rules for the Service Bus Namespace | <pre>list(object({<br>    subnet_id                            = string<br>    ignore_missing_vnet_service_endpoint = optional(bool, false)<br>  }))</pre> | `[]` | no |
| <a name="input_premium_messaging_partitions"></a> [premium\_messaging\_partitions](#input\_premium\_messaging\_partitions) | The number of partitions for Premium Messaging | `number` | `0` | no |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | Is local authentication enabled | `bool` | `true` | no |
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space used by the Virtual Network | `list(string)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A mapping of subnet names to their configurations. | <pre>map(object({<br>    prefix = string<br>    delegation = optional(map(object({<br>      service_name    = string<br>      service_actions = list(string)<br>    })), {})<br>    service_endpoints                             = optional(list(string), []),<br>    private_endpoint_network_policies_enabled     = optional(bool, false)<br>    private_link_service_network_policies_enabled = optional(bool, false)<br>    network_security_group_id                     = optional(string, null)<br>    route_table_id                                = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_servicebus_topics"></a> [servicebus\_topics](#input\_servicebus\_topics) | A map of Service Bus Topics to create | <pre>map(object({<br>    name = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace_id"></a> [namespace\_id](#output\_namespace\_id) | The ID of the Service Bus Namespace |
| <a name="output_namespace_default_primary_connection_string"></a> [namespace\_default\_primary\_connection\_string](#output\_namespace\_default\_primary\_connection\_string) | The primary connection string for the Service Bus Namespace |
| <a name="output_namespace_default_secondary_connection_string"></a> [namespace\_default\_secondary\_connection\_string](#output\_namespace\_default\_secondary\_connection\_string) | The secondary connection string for the Service Bus Namespace |
| <a name="output_namespace_default_primary_key"></a> [namespace\_default\_primary\_key](#output\_namespace\_default\_primary\_key) | The default primary key for the Service Bus Namespace |
| <a name="output_namespace_default_secondary_key"></a> [namespace\_default\_secondary\_key](#output\_namespace\_default\_secondary\_key) | The default secondary key for the Service Bus Namespace |
| <a name="output_topics"></a> [topics](#output\_topics) | The Service Bus topics created |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
