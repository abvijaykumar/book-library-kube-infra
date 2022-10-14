resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }
}

resource "helm_release" "vault" {
    chart      = "hashicorp/vault"
    name       = "vault"
    namespace  = "vault"
    create_namespace = "true"
    repository = "https://helm.releases.hashicorp.com"
    values = [
        "${file("${path.module}/vault-raft-values.yaml")}"
    ]
}