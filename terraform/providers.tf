provider "kubectl" {} # Configured via KUBE_CONFIG_PATH env var

provider "kubernetes" {} # Configured via KUBE_CONFIG_PATH env var

provider "helm" {} # Configured via KUBE_CONFIG_PATH env var

provider "jinja" {}

provider "cloudflare" {} # Authenticated via CLOUDFLARE_API_TOKEN env var
