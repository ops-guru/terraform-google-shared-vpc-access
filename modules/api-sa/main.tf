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
data "google_project" "service_project" {
  project_id = var.service_project_id
}

locals {
  api_s_account = format(
    "%s@cloudservices.gserviceaccount.com",
  data.google_project.service_project.number)
}

/******************************************
  compute.networkUser role granted to API service account on shared VPC subnets
 *****************************************/
resource "google_compute_subnetwork_iam_member" "api_shared_vpc_subnets" {
  provider = google-beta
  count    = length(var.shared_vpc_subnets)
  subnetwork = element(
    split("/", var.shared_vpc_subnets[count.index]),
    index(
      split("/", var.shared_vpc_subnets[count.index]),
      "subnetworks",
    ) + 1,
  )
  role = "roles/compute.networkUser"
  region = element(
    split("/", var.shared_vpc_subnets[count.index]),
    index(split("/", var.shared_vpc_subnets[count.index]), "regions") + 1,
  )
  project = var.host_project_id
  member  = format("serviceAccount:%s", local.api_s_account)
}
