export UNSEAL_KEY=zzr+oQ0MF5uFsg0AJlbUKm5SnZpcOjOK3tlsv6pkVpc=
kubectl exec -n vault -ti vault-0 -- vault operator unseal $UNSEAL_KEY
kubectl exec -n vault -ti vault-1 -- vault operator unseal $UNSEAL_KEY
kubectl exec -n vault -ti vault-2 -- vault operator unseal $UNSEAL_KEY