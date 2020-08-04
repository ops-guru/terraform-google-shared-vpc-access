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

output "host_project_id" {
  value = module.host_project.project_id
}

output "service_project_id" {
  value = module.service_project.project_id
}

output "sa_key" {
  value     = google_service_account_key.int_test.private_key
  sensitive = true
}

output "folder_id" {
  value = google_folder.ci_shared_vpc_access_folder.id
}

output "org_id" {
  value = var.org_id
}

output "billing_account" {
  value = var.billing_account
}

output "network_self_link" {
  value = module.vpc.network_self_link
}

output "network_name" {
  value = module.vpc.network_name
}

output "network" {
  value = module.vpc.network
}

output "random_string_for_testing" {
  value = random_id.random_string_for_testing.hex
}
