# Dataproc Shared VPC Access

This example illustrates how to set subnet permissions in a shared VPC for the [Dataproc](https://cloud.google.com/dataproc/docs/concepts/configuring-clusters/network#creating_a_cluster_that_uses_a_vpc_network_in_another_project).

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
| dataproc\_subnet\_name | Dataproc Subnet Name |
| dataproc\_subnet\_region | Dataproc Subnet Name |
| host\_project\_id | Host Project ID |
| service\_project\_id | Service Project ID |
| service\_project\_number | Service Project Number |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
