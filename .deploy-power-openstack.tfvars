# variables for personal deploy

## Uncomment and set with your w3 email
#user_name = "" # if unset will look for env var `TF_VAR_user_name`

## Uncomment and set with your w3 password
#password = "" # if unset will look for env var `TF_VAR_password`

tenant_id = "aeee5c559bed40b98724e8b7f74fa00e"

tenant_name = "BlueRidgeGroup-P"

os_private_network = "BlueRidgeGroup-P_network"

availability_zone = "power"

os_image_name = "cicd-u16.04-2018-01-02-ppc64le"

icp_version = "token:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJmZTI1ZDQzZS1iNzBlLTU2NDctOGE5Yy0wNjFjZjUyZDI2ODYiLCJpc3MiOiJyZWdpc3RyeS5ibHVlbWl4Lm5ldCJ9.Pn9Vf7sNCQahDWfj2Xi9kGXzq-0hGFnAGhqqpUrWwt4@registry.ng.bluemix.net/mdelder/icp-inception-ppc64le:2.1.0.3-rc2"

icp_configuration = {
  disabled_management_services = ["istio", "vulnerability-advisor", "custom-metrics-adapter", "service-catalog", "metering", "va"]
  etcd_extra_args              = ["--grpc-keepalive-timeout=0", "--grpc-keepalive-interval=0", "--snapshot-count=10000"]
  private_registry_enabled     = "true"
  private_registry_server      = "registry.ng.bluemix.net"
  image_repo                   = "registry.ng.bluemix.net/mdelder"
  docker_username              = "token"
  docker_password              = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJmZTI1ZDQzZS1iNzBlLTU2NDctOGE5Yy0wNjFjZjUyZDI2ODYiLCJpc3MiOiJyZWdpc3RyeS5ibHVlbWl4Lm5ldCJ9.Pn9Vf7sNCQahDWfj2Xi9kGXzq-0hGFnAGhqqpUrWwt4"
}
