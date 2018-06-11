#!/usr/bin/env bats

# This will load the helpers.
load ../../helpers

@test "management-ingress | Check the unified-router nodedetails api by ingress" {
    # Check the unified-router nodedetails api by ingress

    master_ip=$($KUBECTL get cm oauth-client-map -n services -o jsonpath='{.data.MASTER_IP}')
    token_id=$($KUBECTL config view -o jsonpath='{.users[?(@.name == "admin")].user.token}')

    request_code=$(curl --connect-timeout 5 -s -w "%{http_code}" -k -H "Authorization: Bearer $token_id" https://${master_ip}:8443/unified-router/api/v1/nodedetail -o /dev/null)

    [[ $request_code == '200' ]]
}

@test "management-ingress | Check incorrect AuthZ to unified-router nodedetails api by ingress" {
    # Check the unified-router nodedetails api by ingress

    master_ip=$($KUBECTL get cm oauth-client-map -n services -o jsonpath='{.data.MASTER_IP}')
    token_id='incorrect token'

    request_code=$(curl --connect-timeout 5 -s -w "%{http_code}" -k -H "Authorization: Bearer $token_id" https://${master_ip}:8443/unified-router/api/v1/nodedetail -o /dev/null)

    [[ $request_code == '401' ]]
}
