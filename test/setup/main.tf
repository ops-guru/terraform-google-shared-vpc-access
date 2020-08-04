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
  parent = var.folder_id == "" ? "organizations/${var.org_id}" : "folders/${replace(var.folder_id, "folders/", "")}"
}

resource "google_folder" "ci_shared_vpc_access_folder" {
  display_name = "ci-svpc-access-folder-${random_id.folder_rand.hex}"
  parent       = local.parent
}

module "host_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 8.0"

  name                 = "ci-svpc-access-host-tests"
  random_project_id    = true
  org_id               = var.org_id
  folder_id            = google_folder.ci_shared_vpc_access_folder.id
  billing_account      = var.billing_account
  skip_gcloud_download = true
  lien                 = false

  disable_services_on_destroy = "false"
}

module "vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 2.0"

  project_id   = module.host_project.project_id
  network_name = "ci-test-vpc"

  shared_vpc_host = true
}

module "service_project" {
  source  = "terraform-google-modules/project-factory/google//modules/shared_vpc"
  version = "~> 8.0"

  name                 = "ci-svpc-access-svc-tests"
  random_project_id    = true
  org_id               = var.org_id
  folder_id            = google_folder.ci_shared_vpc_access_folder.id
  billing_account      = var.billing_account
  shared_vpc           = module.vpc.project_id
  shared_vpc_enabled   = true
  skip_gcloud_download = true
  lien                 = false

  disable_services_on_destroy = "false"
}

resource "random_id" "random_string_for_testing" {
  byte_length = 3
}
