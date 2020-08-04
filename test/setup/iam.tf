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

locals {
  int_required_project_roles = [
    "roles/resourcemanager.projectIamAdmin",
    "roles/compute.admin",
  ]
}

resource "google_service_account" "int_test" {
  project      = module.host_project.project_id
  account_id   = "svpc-access-int-test"
  display_name = "svpc-access-int-test"
}

resource "google_project_iam_member" "int_test_host_project" {
  for_each = toset(local.int_required_project_roles)

  project = module.host_project.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_project_iam_member" "int_test_service_project" {
  for_each = toset(local.int_required_project_roles)

  project = module.service_project.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_service_account_key" "int_test" {
  service_account_id = google_service_account.int_test.id
}
