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
  description = "Service project ID."
  value       = var.service_project_id
  depends_on = [
    google_compute_subnetwork_iam_member.api_shared_vpc_subnets,
  ]
}

output "host_project_id" {
  description = "Host project ID."
  value       = var.host_project_id
  depends_on = [
    google_compute_subnetwork_iam_member.api_shared_vpc_subnets,
  ]
}

output "service_project_number" {
  description = "Service Project Number"
  value       = data.google_project.service_project.number
}

output "shared_vpc_subnets" {
  description = "Shared VPC Subnets"
  value       = var.shared_vpc_subnets
  depends_on  = [google_compute_subnetwork_iam_member.api_shared_vpc_subnets]
}
