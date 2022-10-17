helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add jetstack https://charts.jetstack.io
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add argocd https://argoproj.github.io/argo-helm
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

helm repo update

helm upgrade -i  -n monitoring --create-namespace prometheus prometheus-community/kube-prometheus-stack 
helm upgrade -i  --create-namespace -n monitoring redis-exporter prometheus-community/prometheus-redis-exporter --values ./values/redis-exporter-helm-values.yaml
helm upgrade -i  --create-namespace -n monitoring postgres-exporter prometheus-community/prometheus-postgres-exporter --values ./values/postgres-exporter-helm-values.yaml
helm upgrade -i  --create-namespace -n monitoring loki grafana/loki-stack --values ./values/loki-stack-values.yaml
helm upgrade -i  --create-namespace -n argocd argocd/argo-cd
helm upgrade -i  --create-namespace -n ingress-nginx ingress-nginx ingress-nginx/ingress-nginx
helm upgrade -i  --create-namespace -n cert-manager cert-manager jetstack/cert-manager --values ./values/cert-manager-values.yaml
helm upgrade -i  --create-namespace -n vault vault hashicorp/vault   --values ./values/vault-raft-values.yaml



helm upgrade -i  --create-namespace -n tracing jaeger jaegertracing/jaeger-operator --values ./values/jaeger-vaules.yaml
helm upgrade -i  --create-namespace -n tracing jaeger jaegertracing/jaeger

helm upgrade -i  --create-namespace -n observability my-opentelemetry-collector open-telemetry/opentelemetry-collector

kubectl patch ds -n monitoring prometheus-prometheus-node-exporter --type "json" -p '[{"op": "remove", "path" : "/spec/template/spec/containers/0/volumeMounts/2/mountPropagation"}]'
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml





