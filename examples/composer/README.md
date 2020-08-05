# Dataproc Shared VPC Access

This example illustrates how to set subnet permissions in a shared VPC for the [Cloud composer](https://cloud.google.com/composer/docs/how-to/managing/configuring-shared-vpc).

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