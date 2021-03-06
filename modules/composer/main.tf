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
  cloud_composer_s_account = format(
    "service-%s@cloudcomposer-accounts.iam.gserviceaccount.com",
  data.google_project.service_project.number)
}

/******************************************
  compute.networkUser role granted to cloudcomposer service account on shared VPC subnets
  See: https://cloud.google.com/composer/docs/how-to/managing/configuring-shared-vpc
 *****************************************/
resource "google_project_iam_member" "composer_sa_access" {
  role    = "roles/compute.networkUser"
  project = var.host_project_id
  member  = format("serviceAccount:%s", local.cloud_composer_s_account)
}
