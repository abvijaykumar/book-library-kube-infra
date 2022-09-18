kubectl exec -n vault vault-0 -- vault operator init \
                                               -key-shares=1 \
                                               -key-threshold=1 \
                                               -format=json >        cluster-keys.json


vault auth enable kubernetes
vault write auth/kubernetes/config \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443"

vault policy write bozobooks-app-policy - <<EOF
path "bozobooks/data/googleapi-config" {
  capabilities = ["read"]
}
EOF

vault write auth/kubernetes/role/bozobooks-app \
    bound_service_account_names=bozobooks-app \
    bound_service_account_namespaces=bozo-book-library-dev \
    policies=bozobooks-app-policy \
    ttl=24h

exit

kubectl get serviceaccounts
kubectl create sa -n bozo-book-library-dev bozobooks-app
kubectl get serviceaccounts