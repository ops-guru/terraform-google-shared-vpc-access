# GKE Shared VPC Access

This example illustrates how to set subnet permissions in a shared VPC for the [GKE](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| host\_project\_id | The ID of the host project which hosts the shared VPC | string | n/a | yes |
| network\_name | Shared VPC Network Name | string | n/a | yes |
| service\_project\_id | The ID of the service project | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| gke\_subnet\_name | GKE Subnet Name |
| gke\_subnet\_region | GKE Subnet Name |
| host\_project\_id | Host Project ID |
| service\_project\_id | Service Project ID |
| service\_project\_number | Service Project Number |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
