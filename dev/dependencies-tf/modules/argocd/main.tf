
resource "kubernetes_namespace" "monitoring-tf" {
  metadata {
    name = "argocd-tf"
  }
}

resource "helm_release" "argocd" {
    chart      = "kube-prometheus-stack"
    name       = "prometheus"
    namespace  = "monitoring-tf"
    repository = "https://prometheus-community.github.io/helm-charts"
    values = [
        "${file("/Users/vijaykumarab/AB-Home/Developer/book-library/book-library-kube-infra/dev/monitoring/prometheus/kube-prometheus-stack-helm-values.yaml")}"
    ]
}


resource "helm_release" "redis-exporter" {
    chart      = "prometheus-redis-exporter"
    name       = "redis-exporter"
    namespace  = "monitoring-tf"
    repository = "https://prometheus-community.github.io/helm-charts"
    values = [
        "${file("/Users/vijaykumarab/AB-Home/Developer/book-library/book-library-kube-infra/dev/monitoring/prometheus/redis-exporter-helm-values.yaml")}"
    ]
}

resource "helm_release" "postgres-exporterr" {
    chart      = "prometheus-postgres-exporter"
    name       = "postgres-exporter"
    namespace  = "monitoring-tf"
    repository = "https://prometheus-community.github.io/helm-charts"
    values = [
        "${file("/Users/vijaykumarab/AB-Home/Developer/book-library/book-library-kube-infra/dev/monitoring/prometheus/postgres-exporter-helm-values.yaml")}"
    ]
}

resource "helm_release" "loki" {
    chart      = "grafana/loki-stack"
    name       = "redis-exporter"
    namespace  = "monitoring-tf"
    repository = "https://grafana.github.io/helm-charts"
    values = [
        "${file("/Users/vijaykumarab/AB-Home/Developer/book-library/book-library-kube-infra/dev/monitoring/loki/bozo-loki-stack-values.yaml")}"
    ]
}