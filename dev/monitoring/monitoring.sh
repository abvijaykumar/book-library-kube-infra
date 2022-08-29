
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create ns monitoring

helm install -n monitoring kube-prometheus prometheus-community/kube-prometheus-stack -f /Users/vijaykumarab/AB-Home/Developer/book-library/book-library-kube-infra/dev/monitoring/prometheus/kube-prometheus-stack-helm-values.yaml
helm install -n monitoring postgres-exporter prometheus-community/prometheus-postgres-exporter -f /Users/vijaykumarab/AB-Home/Developer/book-library/book-library-kube-infra/dev/monitoring/postgres-exporter-helm-values.yaml
helm install -n monitoring redis-exporter prometheus-community/prometheus-redis-exporter -f /Users/vijaykumarab/AB-Home/Developer/book-library/book-library-kube-infra/dev/monitoring/redis-exporter-helm-values.yaml

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm search repo grafana
helm show values grafana/loki-stack > loki-values.yaml

helm install loki -n monitoring grafana/loki-stack -f loki-values.yaml