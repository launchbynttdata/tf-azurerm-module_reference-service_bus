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

output "namespace_id" {
  description = "The ID of the Service Bus Namespace"
  value       = module.servicebus_namespace.id
}

output "namespace_name" {
  description = "The name of the Service Bus Namespace"
  value       = module.servicebus_namespace.name
}

output "namespace_endpoint" {
  description = "The endpoint for the Service Bus Namespace"
  value       = module.servicebus_namespace.endpoint
}

output "namespace_default_primary_connection_string" {
  description = "The primary connection string for the Service Bus Namespace"
  value       = module.servicebus_namespace.default_primary_connection_string
}

output "namespace_default_secondary_connection_string" {
  description = "The secondary connection string for the Service Bus Namespace"
  value       = module.servicebus_namespace.default_secondary_connection_string
}

output "namespace_default_primary_key" {
  description = "The default primary key for the Service Bus Namespace"
  value       = module.servicebus_namespace.default_primary_key
}

output "namespace_default_secondary_key" {
  description = "The default secondary key for the Service Bus Namespace"
  value       = module.servicebus_namespace.default_secondary_key
}

output "topics" {
  description = "The Service Bus topics created"
  value       = module.servicebus_topic[*]
}
