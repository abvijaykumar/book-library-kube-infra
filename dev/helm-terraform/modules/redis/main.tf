resource "kubernetes_namespace" "bozobooks-redis" {
  metadata {
    name = "bozobooks-redis"
  }
}

resource "helm_release" "redis" {
    chart      = "ot-helm/redis-operator"
    name       = "redis-operator"
    namespace  = "bozobooks-redis"
    create_namespace = "true"
    repository = "https://ot-container-kit.github.io/helm-charts/"
    values = [
        "${file("${path.module}/redis-values.yaml")}"
    ]
}