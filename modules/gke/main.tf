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
  gke_s_account = format(
    "service-%s@container-engine-robot.iam.gserviceaccount.com",
  data.google_project.service_project.number)
}

/******************************************
  compute.networkUser role granted to GKE service account for GKE on shared VPC subnets
  See: https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc
 *****************************************/
resource "google_compute_subnetwork_iam_member" "gke_shared_vpc_subnets" {
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
  member  = format("serviceAccount:%s", local.gke_s_account)
}

/******************************************
  container.hostServiceAgentUser role granted to GKE service account for GKE on shared VPC
  See:https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc
 *****************************************/
resource "google_project_iam_member" "gke_host_agent" {
  project = var.host_project_id
  role    = "roles/container.hostServiceAgentUser"
  member  = format("serviceAccount:%s", local.gke_s_account)
}
