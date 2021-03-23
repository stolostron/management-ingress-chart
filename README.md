# Management Ingress Chart

## Overview
This management-ingress-chart installs Management Ingress in your cluster.

## Chart Details
This chart:
* Installs Management Ingress chart.
* Adds a daemonset to running Management Ingress pod on master nodes.
* Adds a service management-ingress.
* Adds a configmap to configure ssl-ciphers.
* Adds a Certificate.

## Developing for management ingress chart
### Prerequisites
* Installing a PodDisruptionBudget
* Kubernetes v1.11+
* OpenShift 3.11+
* Tiller v2.12+

### Resources Required
* cpu: 200m
* memory: 256Mi

### Installing the Chart
```
helm install --namespace kube-system --name management-ingress management-ingress
```

### Configuration
The following table lists the configurable parameters of the `Management Ingress` chart and their default values.

| Parameter                              | Description                                                    | Default                       |
|----------------------------------------|----------------------------------------------------------------|-------------------------------|
| resources.requests.cpu                 | cpu request to run this deployment                             | 200m                          |
| resources.requests.memory              | memory request to run this deployment                          | 256Mi                         |
| config.disable-access-log              | Management Ingress configmap setting of disable-access-log     | true                          |
| config.ssl-ciphers                     | Management Ingress configmap setting of ssl-ciphers            | ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256|
| nodeSelector.master                    | deploy this chart on master node                               | true                          |
| tolerations.key                        | tolerations key of this deployment                             | dedicated                     |
| tolerations.operator                   | tolerations operator of this deployment                        | Exists                        |
| tolerations.effect                     | tolerations effect of this deployment                          | NoSchedule                    |
| host_headers_check_enabled             | enable/disable host header check                               | false                         |
| allowed_host_headers                   | allowed host headers list, seperated by space                  | 127.0.0.1 localhost           |
| httpPort                               | Listening http port of nginx backend                           | 8080                          |
| httpsPort                              | Listening https port of nginx backend                          | 8443                          |
| hostPort                               | exposing container port as host port                           | true                          |
| hostNetwork                            | using host network                                             | false                         |
| fips_enabled                           | enable/disable fips mode                                       | false                         |
| enable_impersonation                   | enable/disable impersonation setting                           | false                         |
| apiserver_secure_port                  | kubernetes apiserver secure port                               | 8001                          |

## Contributing
* See [CONTRIBUTING.md](CONTRIBUTING.md) for information about the workflow that we expect, and instructions on the developer certificate of origin that we require.
