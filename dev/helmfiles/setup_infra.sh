helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add jetstack https://charts.jetstack.io
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add argocd https://argoproj.github.io/argo-helm
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

# helm repo add jaegertracing https://jaegertracing.github.io/helm-charts

helm repo add openzipkin https://openzipkin.github.io/zipkin


helm repo update

helm upgrade -i  -n monitoring --create-namespace prometheus prometheus-community/kube-prometheus-stack 
helm upgrade -i  --create-namespace -n monitoring redis-exporter prometheus-community/prometheus-redis-exporter --values ./values/redis-exporter-helm-values.yaml
helm upgrade -i  --create-namespace -n monitoring postgres-exporter prometheus-community/prometheus-postgres-exporter --values ./values/postgres-exporter-helm-values.yaml
helm upgrade -i  --create-namespace -n monitoring loki grafana/loki-stack --values ./values/loki-stack-values.yaml
helm upgrade -i  --create-namespace -n argocd argocd/argo-cd
helm upgrade -i  --create-namespace -n ingress-nginx ingress-nginx ingress-nginx/ingress-nginx
helm upgrade -i  --create-namespace -n cert-manager cert-manager jetstack/cert-manager --values ./values/cert-manager-values.yaml
helm upgrade -i  --create-namespace -n vault vault hashicorp/vault   --values ./values/vault-raft-values.yaml

kubectl patch ds -n monitoring prometheus-prometheus-node-exporter --type "json" -p '[{"op": "remove", "path" : "/spec/template/spec/containers/0/volumeMounts/2/mountPropagation"}]'
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


helm upgrade -i --create-namespace -n opentelemetry opentelemetry-collector open-telemetry/opentelemetry-collector --values ./values/opentelemetry-collector-values.yaml
helm upgrade -i --create-namespace -n opentelemetry opentelemetry-operator open-telemetry/opentelemetry-operator --values ./values/opentelemetry-operator-values.yaml

# helm upgrade -i  --create-namespace -n jaeger-operator jaeger-operator jaegertracing/jaeger-operator --values ./values/jaeger-operator-values.yaml
# helm upgrade -i  --create-namespace -n jaeger jaeger jaegertracing/jaeger --values ./values/jaeger-values.yaml

