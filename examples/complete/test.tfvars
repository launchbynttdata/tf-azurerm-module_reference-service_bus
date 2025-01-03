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
tags = {
  Purpose = "Terratest"
}

configure_identity = true
identity_type      = "SystemAssigned"
// "Premium" is required for network rules
sku = "Premium"
// For "Premium" SKU, the following parameters must not be 0
capacity                     = 1
premium_messaging_partitions = 1

address_space = ["10.10.10.0/24"] // for the vnet to add to the rules

subnets = {
  subnet_a = {
    prefix = "10.10.10.0/26"
  }
}

network_rule_set = {
  default_action                = "Allow" // This can not be set to "Deny" unless there are network or IP rules
  public_network_access_enabled = true
  trusted_services_allowed      = true
  ip_rules                      = []
}
