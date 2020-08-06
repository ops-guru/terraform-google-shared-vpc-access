# Dataproc Shared VPC Access

This module grants IAM permissions on host project and subnets for dataproc.

## Example Usage
```hcl
module "dataproc_shared_vpc_access" {
  source              = "terraform-google-modules/shared-vpc-access/google//modules/dataproc"
  host_project_id     = var.shared_vpc
  service_project_id  = var.service_project
  shared_vpc_subnets  = [
    "projects/pf-ci-shared2/regions/us-west1/subnetworks/shared-network-subnet-01",
    "projects/pf-ci-shared2/regions/us-west1/subnetworks/shared-network-subnet-02",
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| host\_project\_id | The ID of the host project which hosts the shared VPC | string | n/a | yes |
| service\_project\_id | The ID of the service project | string | n/a | yes |
| shared\_vpc\_subnets | List of subnets fully qualified subnet IDs (ie. projects/$project_id/regions/$region/subnetworks/$subnet_id) | list(string) | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| host\_project\_id | Host project ID. |
| service\_project\_id | Service project ID. |
| service\_project\_number | Service Project Number |
| shared\_vpc\_subnets | Shared VPC Subnets |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
