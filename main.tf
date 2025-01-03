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

module "servicebus_namespace" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/servicebus_namespace/azurerm"
  version = "~> 1.2"

  resource_group_name          = var.resource_group_name
  name                         = var.namespace_name
  location                     = var.region
  sku                          = var.sku
  configure_identity           = var.configure_identity
  identity_type                = var.identity_type
  network_rule_set             = var.network_rule_set
  capacity                     = var.capacity
  premium_messaging_partitions = var.premium_messaging_partitions
  network_rules                = var.network_rules

  tags = var.tags
}

module "servicebus_topic" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/servicebus_topic/azurerm"
  version = "~> 1.0"

  for_each = var.servicebus_topics

  namespace_id = module.servicebus_namespace.id
  name         = each.value.name
}
