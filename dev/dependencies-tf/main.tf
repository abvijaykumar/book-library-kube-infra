provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "vault" {
  source = "./modules/vault"
}

module "monitoring-stack" {
  source = "./modules/monitoring-stack"
}

module "argocd" {
  source = "./modules/argocd"
}

