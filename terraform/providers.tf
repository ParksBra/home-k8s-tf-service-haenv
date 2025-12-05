provider "azuredevops" {} # Configured via AZDO_PERSONAL_ACCESS_TOKEN, AZDO_ORG_SERVICE_URL env vars

provider "kubectl" {} # Configured via KUBE_CONFIG_PATH env var

provider "kubernetes" {} # Configured via KUBE_CONFIG_PATH env var

provider "helm" {} # Configured via KUBE_CONFIG_PATH env var

provider "jinja" {}

provider "cloudflare" {} # Authenticated via CLOUDFLARE_API_TOKEN env var
