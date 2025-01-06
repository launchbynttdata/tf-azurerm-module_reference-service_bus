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
  value       = module.servicebus.namespace_id
}

output "namespace_endpoint" {
  description = "The endpoint for the Service Bus Namespace"
  value       = module.servicebus.namespace_endpoint
}

output "namespace_name" {
  description = "The name of the Service Bus Namespace"
  value       = module.servicebus.namespace_name
}

output "namespace_default_primary_connection_string" {
  description = "The primary connection string for the Service Bus Namespace"
  value       = module.servicebus.namespace_default_primary_connection_string
  sensitive   = true
}

output "namespace_default_secondary_connection_string" {
  description = "The secondary connection string for the Service Bus Namespace"
  value       = module.servicebus.namespace_default_secondary_connection_string
  sensitive   = true
}

output "namespace_default_primary_key" {
  description = "The default primary key for the Service Bus Namespace"
  value       = module.servicebus.namespace_default_primary_key
  sensitive   = true
}

output "namespace_default_secondary_key" {
  description = "The default secondary key for the Service Bus Namespace"
  value       = module.servicebus.namespace_default_secondary_key
  sensitive   = true
}

output "topics" {
  description = "The Service Bus topics created"
  value       = module.servicebus.topics
}

//for the tests...
output "topic1_name" {
  description = "The name of the first topic"
  value       = module.servicebus.topics[0].topic1.name
}

output "topic2_name" {
  description = "The name of the second topic"
  value       = module.servicebus.topics[0].topic2.name
}
