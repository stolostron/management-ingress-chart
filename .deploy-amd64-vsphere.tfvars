## variables for vsphere deploy 

## Uncomment and set with your vsphere login credentials
#vsphere_user_name = "" # if unset will look for env var `TF_VAR_vsphere_user_name`
#vsphere_password  = "" # if unset will look for env var `TF_VAR_vsphere_password`

## Uncomment and set with your w3 email
#user_name = ""  # if unset will look for env var `TF_VAR_user_name`

## Uncomment and set with the details of your vsphere allocated ip address
##      If you have multiple public ip addresses, include them in the list. Only the first value is currently used
#public_network_ip = [""] # if unset will look for env var `TF_VAR_public_network_ip`
## supported subnets are: VIS232, VIS232B, VIS241
##      If you have multiple public ip addresses, include the subnet for each. Only the first value is currently used
#public_network_subnet = [""] # if unset will look for env var `TF_VAR_public_network_subnet`

#os_imaage_name = "cicd-u16.04-2018-24-04"

#verbose = "-vvv"

icp_version = "token:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJmZTI1ZDQzZS1iNzBlLTU2NDctOGE5Yy0wNjFjZjUyZDI2ODYiLCJpc3MiOiJyZWdpc3RyeS5ibHVlbWl4Lm5ldCJ9.Pn9Vf7sNCQahDWfj2Xi9kGXzq-0hGFnAGhqqpUrWwt4@registry.ng.bluemix.net/mdelder/icp-inception:2.1.0.2"

icp_configuration = {
  disabled_management_services = ["istio", "vulnerability-advisor", "custom-metrics-adapter", "service-catalog", "metering", "va"]
  etcd_extra_args              = ["--grpc-keepalive-timeout=0", "--grpc-keepalive-interval=0", "--snapshot-count=10000"]
  private_registry_enabled     = "true"
  private_registry_server      = "registry.ng.bluemix.net"
  image_repo                   = "registry.ng.bluemix.net/mdelder"
  docker_username              = "token"
  docker_password              = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJmZTI1ZDQzZS1iNzBlLTU2NDctOGE5Yy0wNjFjZjUyZDI2ODYiLCJpc3MiOiJyZWdpc3RyeS5ibHVlbWl4Lm5ldCJ9.Pn9Vf7sNCQahDWfj2Xi9kGXzq-0hGFnAGhqqpUrWwt4"
}
