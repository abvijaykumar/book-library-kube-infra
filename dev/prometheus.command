helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring

failed to try resolving symlinks in path "/var/log/pods/monitoring_prometheus-node-exporter


kubectl patch ds -n monitoring prom-stack-prometheus-node-exporter --type "json" -p '[{"op": "remove", "path" : "/spec/template/spec/containers/0/volumeMounts/2/mountPropagation"}]'


helm install -n monitoring prom-stack prometheus-community/kube-prometheus-stack
helm install -n monitoring redis-exporter prometheus-community/prometheus-redis-exporter -f /Users/vijaykumarab/AB-Home/Developer/book-library/book-library-kube-infra/dev/monitoring/prometheus/redis-exporter-helm-values.yaml
helm install -n monitoring postgres-exporter prometheus-community/prometheus-postgres-exporter -f /Users/vijaykumarab/AB-Home/Developer/book-library/book-library-kube-infra/dev/monitoring/prometheus/postgres-exporter-helm-values.yaml
helm install loki -n monitoring grafana/loki-stack -f /Users/vijaykumarab/AB-Home/Developer/book-library/book-library-kube-infra/dev/monitoring/loki/bozo-loki-stack-values.yaml


helm install loki -n monitoring grafana/loki-stack -f /Users/vijaykumarab/AB-Home/Developer/book-library/book-library-kube-infra/dev/monitoring/loki/loki-values.yaml