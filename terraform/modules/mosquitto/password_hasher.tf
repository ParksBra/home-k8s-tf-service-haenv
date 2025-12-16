locals {
  generate_password = var.admin_password == null
  generated_password_length = 32
  generated_salt_length     = 12
}

resource "random_password" "admin_password" {
  count            = local.generate_password ? 1 : 0
  length           = local.generated_password_length
  special          = false
  numeric          = true
  lower            = true
  upper            = true
  min_lower        = floor((local.generated_password_length / 2) / 3)
  min_upper        = ceil((local.generated_password_length / 2) / 3)
  min_numeric      = floor((local.generated_password_length / 2) / 3)
  keepers          = {
    generated_password_length = local.generated_password_length
  }
}

resource "random_password" "admin_salt" {
  length           = local.generated_salt_length
  special          = false
  numeric          = false
  lower            = true
  upper            = true
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 0
  keepers          = {
    generated_salt_length = local.generated_salt_length
    admin_password        = local.admin_password
  }
}

data "external" "mosquitto_password_hasher" {
  depends_on = [
    random_password.admin_password,
    random_password.admin_salt,
  ]
  program = ["/bin/sh", "${path.module}/scripts/mosquitto_password_hasher.sh", local.admin_password, random_password.admin_salt.result]
}
