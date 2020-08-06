/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "service_project_id" {
  description = "Service Project ID"
  value       = module.gke_svpc_access.service_project_id
}

output "host_project_id" {
  description = "Host Project ID"
  value       = module.gke_svpc_access.host_project_id
}

output "service_project_number" {
  description = "Service Project Number"
  value       = module.gke_svpc_access.service_project_number
}

output "gke_subnet_name" {
  description = "GKE Subnet Name"
  value       = module.gke_svpc_access.gke_subnet_name
}

output "gke_subnet_region" {
  description = "GKE Subnet Name"
  value       = module.gke_svpc_access.gke_subnet_region
}
