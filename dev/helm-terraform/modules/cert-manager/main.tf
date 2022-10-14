resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "certi-manager"
  }
}

resource "helm_release" "cert-manager" {
    chart      = "jetstack/cert-manager"
    name       = "cert-manager"
    namespace  = "cert-manager"
    create_namespace = "true"
    repository = "https://charts.jetstack.io"
    values = [
        "${file("${path.module}/cert-manager-values.yaml")}"
    ]
}