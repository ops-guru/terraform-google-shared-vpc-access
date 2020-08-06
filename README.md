# Google Shared VPC Access Terraform Module

This is a collection of submodules that set IAM permissions on Shared VPC to appropriate API service accounts.
* [GKE](modules/gke)
* [Dataproc](modules/dataproc)
* [Cloud Composer](modules/composer)
* [API Service Agent](modules/api-sa)


## Compatibility

This module is meant for use with Terraform 0.12.

## Usage

Full examples are in the [examples](./examples/) folder, but basic usage is as follows for managing shared VPC access.

```hcl
# Grants compute.networkUser on shared_vpc_subnets to API Agent Service Account
module "api_agent_sa" {
  source              = "terraform-google-modules/shared-vpc-access/google//modules/api-sa"
  host_project_id     = var.host_project
  service_project_id  = var.service_project
  shared_vpc_subnets  = [
    "projects/pf-ci-shared2/regions/us-west1/subnetworks/shared-network-subnet-01",
    "projects/pf-ci-shared2/regions/us-west1/subnetworks/shared-network-subnet-02",
  ]
}
# Grants compute.networkUser on shared_vpc_subnets to GKE Agent Service Account
module "gke_shared_vpc_access" {
  source              = "terraform-google-modules/shared-vpc-access/google//modules/gke"
  host_project_id     = var.host_project
  service_project_id  = var.service_project
  shared_vpc_subnets  = [
    "projects/pf-ci-shared2/regions/us-west1/subnetworks/shared-network-subnet-01",
    "projects/pf-ci-shared2/regions/us-west1/subnetworks/shared-network-subnet-02",
  ]
}
```

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) 0.12
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) 3.30
- [terraform-provider-google-beta](https://github.com/terraform-providers/terraform-provider-google-beta) 3.30

### Permissions

In order to execute a submodule you must have a Service Account with an appropriate role to manage IAM for the applicable resource. The appropriate role differs depending on which resource you are targeting, as follows:

- Host Project:
  - Projects IAM Admin: allows users to administer IAM policies on projects.
- Service Project:
  - Projects IAM Admin: allows users to administer IAM policies on projects.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.
