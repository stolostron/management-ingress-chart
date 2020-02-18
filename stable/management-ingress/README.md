## Introduction
This chart installs ICP Management Ingress for IBM Cloud Private in your cluster.

## Chart Details
This chart:
* Installs ICP Management Ingress.
* Adds a daemonset to running ICP Management Ingress pod on master nodes.
* Adds a service icp-management-ingress.
* Adds a configmap to configure ssl-ciphers.
* Adds a Certificate.

## Prerequisites
* Installing a PodDisruptionBudget
* Kubernetes v1.11+
* OpenShift 3.11+
* Tiller v2.12+

### PodSecurityPolicy Requirements
The predefined PodSecurityPolicy name: [`ibm-restricted-psp`](https://ibm.biz/cpkspec-psp) has been verified for this chart, if your target namespace is bound to this PodSecurityPolicy you can proceed to install the chart.

Custom PodSecurityPolicy definition:
```
apiVersion: extensions/v1beta1
kind: PodSecurityPolicy
metadata:
  annotations:
    kubernetes.io/description: "This policy grants access to all privileged
      host features and allows a pod to run with any
      UID and GID and any volume.
      WARNING:  This policy is the least restrictive and
      should only used for cluster administration.
      Use with caution."
    seccomp.security.alpha.kubernetes.io/allowedProfileNames: '*'
  name: ibm-privileged-psp
spec:
  allowPrivilegeEscalation: true
  allowedCapabilities:
    - '*'
  allowedUnsafeSysctls:
    - '*'
  fsGroup:
    rule: RunAsAny
  hostIPC: true
  hostNetwork: true
  hostPID: true
  hostPorts:
    - max: 65535
      min: 0
  privileged: true
  runAsUser:
    rule: RunAsAny
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
  volumes:
    - '*'
```
### Red Hat OpenShift SecurityContextConstraints Requirements
The predefined SecurityContextConstraints name: [`ibm-restricted-scc`](https://ibm.biz/cpkspec-scc) has been verified for this chart, if your target namespace is bound to this SecurityContextConstraints resource you can proceed to install the chart.

## Resources Required
* cpu: 200m
* memory: 256Mi

## Installing the Chart
```
helm install --namespace kube-system --name icp-management-ingress icp-management-ingress --tls
```

## Configuration
The following table lists the configurable parameters of the `ICP Management Ingress` chart and their default values.

| Parameter                              | Description                                                    | Default                       |
|----------------------------------------|----------------------------------------------------------------|-------------------------------|
| image.repository                       | ICP Management Ingress image to use for this deployment        | ibmcom/icp-management-ingress |
| image.tag                              | ICP Management Ingress image tag to use for this deployment    | 2.5.0                         |
| image.pullPolicy                       | ICP Management Ingress pull policy                             | IfNotPresent                  |
| resources.requests.cpu                 | cpu request to run this deployment                             | 200m                          |
| resources.requests.memory              | memory request to run this deployment                          | 256Mi                         |
| config.disable-access-log              | ICP Management Ingress configmap setting of disable-access-log | true                          |
| config.ssl-ciphers                     | ICP Management Ingress configmap setting of ssl-ciphers        | ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256|
| nodeSelector.master                    | deploy this chart on master node                               | true                          |
| tolerations.key                        | tolerations key of this deployment                             | dedicated                     |
| tolerations.operator                   | tolerations operator of this deployment                        | Exists                        |
| tolerations.effect                     | tolerations effect of this deployment                          | NoSchedule                    |
| cert.issuer.name                       | cert issuer name of this deployment                            | icp-ca-issuer                 |
| cert.issuer.kind                       | cert issuer kind of this deployment                            | ClusterIssuer                 |
| cert.duration                          | cert issuer duration of this deployment                        | 2160h                         |
| cert.renewBefore                       | cert issuer renewBefore time of this deployment                | 24h                           |
| cluster_domain                         | cluster domain name                                            | cluster.local                 |
| cluster_ca_domain                      | cluster ca domain name                                         | mycluster.icp                 |
| oidc_secret                            | platform oidc credentials                                      | platform-oidc-credentials     |
| cluster_address                        | cluster external address ip                                    | 127.0.0.1                     |
| cluster_internal_address               | cluster internal address ip                                    | 127.0.0.1                     |
| host_headers_check_enabled             | enable/disable host header check                               | true                          |
| allowed_host_headers                   | allowed host headers list, seperated by space                  | 127.0.0.1 mycluster.icp icp-management-ingress iam-token-service |
| httpPort                               | Listening http port of nginx backend                           | 8080                          |
| httpsPort                              | Listening https port of nginx backend                          | 8443                          |
| hostPort                               | exposing container port as host port                           | true                          |
| hostNetwork                            | using host network                                             | false                         |
| fips_enabled                           | enable/disable fips mode                                       | false                         |
| enable_impersonation                   | enable/disable impersonation setting                           | false                         |
| apiserver_secure_port                  | kubernetes apiserver secure port                               | 8001                          |
| internal_use                           | is used internally for externally                              | true                          |

## Limitations
* Works on x86, ppc64le and s390x platform.
* Only users with privileged podsecuritypolicies can install this chart.
