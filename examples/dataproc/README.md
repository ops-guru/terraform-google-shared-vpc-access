# Dataproc Shared VPC Access

This example illustrates how to enable a subnet in shared VPC for a [Dataproc cluster creation]( https://cloud.google.com/dataproc/docs/concepts/configuring-clusters/network#creating_a_cluster_that_uses_a_vpc_network_in_another_project).

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
| host\_project\_id | Host Project ID |
| service\_project\_id | Service Project ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->