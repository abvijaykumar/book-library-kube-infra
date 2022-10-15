helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add jetstack https://charts.jetstack.io
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add argocd https://argoproj.github.io/argo-helm
helm repo add hashicorp https://helm.releases.hashicorp.com

helm repo update

helm install -n monitoring --create-namespace prometheus prometheus-community/kube-prometheus-stack 
helm install --create-namespace -n monitoring redis-exporter prometheus-community/prometheus-redis-exporter --values ./values/redis-exporter-helm-values.yaml
helm install --create-namespace -n monitoring postgres-exporter prometheus-community/prometheus-postgres-exporter --values ./values/postgres-exporter-helm-values.yaml
helm install --create-namespace -n monitoring loki grafana/loki-stack --values ./values/loki-stack-values.yaml
helm install --create-namespace -n argocd argocd/argo-cd
helm install --create-namespace -n ingress-nginx ingress-nginx ingress-nginx/ingress-nginx
helm install --create-namespace -n cert-manager cert-manager jetstack/cert-manager --values ./values/cert-manager-values.yaml
helm install --create-namespace -n vault vault hashicorp/vault   --values ./values/vault-raft-values.yaml

kubectl patch ds -n monitoring prometheus-prometheus-node-exporter --type "json" -p '[{"op": "remove", "path" : "/spec/template/spec/containers/0/volumeMounts/2/mountPropagation"}]'

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml