# Cloud Composer Shared VPC Access

This module grants IAM permissions on host project to cloud composer.

## Example Usage
This example shows how to setup cloudcomposer for shared VPC. THis is done in
combination with [gke](../gke) sub module.
```hcl
module "gke_shared_vpc_access" {
  source              = "terraform-google-modules/shared-vpc-access/google//modules/gke"
  host_project_id     = var.shared_vpc
  service_project_id  = var.service_project
  shared_vpc_subnets  = [
    "projects/pf-ci-shared2/regions/us-west1/subnetworks/shared-network-subnet-01",
    "projects/pf-ci-shared2/regions/us-west1/subnetworks/shared-network-subnet-02",
  ]
}
module "composer_shared_vpc_access" {
  source              = "terraform-google-modules/shared-vpc-access/google//modules/composer"
  host_project_id     = var.shared_vpc
  service_project_id  = var.service_project
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| host\_project\_id | The ID of the host project which hosts the shared VPC | string | n/a | yes |
| service\_project\_id | The ID of the service project | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| host\_project\_id | Host project ID. |
| service\_project\_id | Service project ID. |
| service\_project\_number | Service Project Number |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
