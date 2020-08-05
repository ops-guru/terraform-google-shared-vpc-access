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

provider "google" {
  version = "~> 3.30"
}

provider "google-beta" {
  version = "~> 3.30"
}

provider "null" {
  version = "~> 2.1"
}

provider "random" {
  version = "~> 2.2"
}

resource "random_id" "folder_rand" {
  byte_length = 2
}

locals {
  parent               = var.folder_id == "" ? "organizations/${var.org_id}" : "folders/${replace(var.folder_id, "folders/", "")}"
  host_project_name    = "ci-svpc-access-host-tests"
  host_project_id      = format("${local.host_project_name}-%s", random_id.random_project_id_suffix.hex)
  service_project_name = "ci-svpc-access-svc-tests"
  service_project_id   = format("${local.service_project_name}-%s", random_id.random_project_id_suffix.hex)
  host_services = [
    "cloudresourcemanager.googleapis.com",
    "accesscontextmanager.googleapis.com",
    "serviceusage.googleapis.com",
  ]
  service_services = [
    "cloudresourcemanager.googleapis.com",
    "accesscontextmanager.googleapis.com",
    "serviceusage.googleapis.com",
  ]
}

resource "google_folder" "ci_shared_vpc_access_folder" {
  display_name = "ci-svpc-access-folder-${random_id.folder_rand.hex}"
  parent       = local.parent
}

resource "random_id" "random_project_id_suffix" {
  byte_length = 2
}

resource "google_project" "host" {
  name                = local.host_project_name
  project_id          = local.host_project_id
  folder_id           = google_folder.ci_shared_vpc_access_folder.name
  billing_account     = var.billing_account
  auto_create_network = false
}

resource "google_project_service" "host_services" {
  count                      = length(local.host_services)
  service                    = local.host_services[count.index]
  project                    = google_project.host.project_id
  disable_dependent_services = true
  disable_on_destroy         = false
}

resource "google_project_service" "service_services" {
  count                      = length(local.service_services)
  service                    = local.service_services[count.index]
  project                    = google_project.service.project_id
  disable_dependent_services = true
  disable_on_destroy         = false
}

resource "google_project" "service" {
  name                = local.service_project_name
  project_id          = local.service_project_id
  folder_id           = google_folder.ci_shared_vpc_access_folder.name
  billing_account     = var.billing_account
  auto_create_network = false
}

resource "google_compute_network" "vpc" {
  name                    = "ci-test-vpc"
  project                 = google_project.host.project_id
  auto_create_subnetworks = false
}

resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  project = google_project.host.project_id
}

resource "google_compute_shared_vpc_service_project" "shared_vpc" {
  host_project    = google_project.host.project_id
  service_project = google_project.service.project_id
  depends_on      = [google_compute_network.vpc]
}

resource "random_id" "random_string_for_testing" {
  byte_length = 3
}
