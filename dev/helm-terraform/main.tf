
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
  
}

module "monitoring-stack" {
  source = "./modules/monitoring-stack"
}
module "vault" {
  source = "./modules/vault"
}
