

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus" {
    chart      = "kube-prometheus-stack"
    name       = "prometheus"
    namespace  = "monitoring"
    create_namespace = "true"
    repository = "https://prometheus-community.github.io/helm-charts"
    values = [
        "${file("${path.module}/kube-prometheus-stack-helm-values.yaml")}"
    ]
}

resource "helm_release" "redis-exporter" {
    chart      = "prometheus-redis-exporter"
    name       = "redis-exporter"
    namespace  = "monitoring"
    create_namespace = "true"
    repository = "https://prometheus-community.github.io/helm-charts"
    values = [
        "${file("${path.module}/redis-exporter-helm-values.yaml")}"
    ]
}

resource "helm_release" "postgres-exporter" {
    chart      = "prometheus-postgres-exporter"
    name       = "postgres-exporter"
    namespace  = "monitoring"
    create_namespace = "true"
    repository = "https://prometheus-community.github.io/helm-charts"
    values = [
        "${file("${path.module}/postgres-exporter-helm-values.yaml")}"
    ]
}

resource "helm_release" "loki" {
    chart      = "grafana/loki-stack"
    name       = "loki"
    namespace  = "monitoring"
    create_namespace = "true"
    repository = "https://grafana.github.io/helm-charts"
    values = [
        "${file("${path.module}/bozo-loki-stack-values.yaml")}"
    ]
}
