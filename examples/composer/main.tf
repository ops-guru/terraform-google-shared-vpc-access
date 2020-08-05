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

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  version = "~> 3.30"
}

provider "google-beta" {
  version = "~> 3.30"
}

resource "google_project_service" "composer_api" {
  service                    = "composer.googleapis.com"
  project                    = var.service_project_id
  disable_dependent_services = true
  disable_on_destroy         = false
}

resource "google_project_service" "gke_api" {
  service                    = "container.googleapis.com"
  project                    = var.service_project_id
  disable_dependent_services = true
  disable_on_destroy         = false
}

resource "google_compute_subnetwork" "composer_subnet" {
  ip_cidr_range = "10.10.30.0/24"
  region        = "us-east4"
  name          = "composer-us-east4"
  project       = var.host_project_id
  network       = var.network_name
}

module "api_sa" {
  source             = "../../modules/api-sa"
  host_project_id    = var.host_project_id
  service_project_id = google_project_service.gke_api.project
  shared_vpc_subnets = [google_compute_subnetwork.composer_subnet.self_link]
}

module "gke_shared_vpc" {
  source             = "../../modules/dataproc"
  host_project_id    = var.host_project_id
  service_project_id = google_project_service.gke_api.project
  shared_vpc_subnets = [google_compute_subnetwork.composer_subnet.self_link]
}

module "composer_shared_vpc" {
  source             = "../../modules/composer"
  host_project_id    = var.host_project_id
  service_project_id = google_project_service.composer_api.project
}
