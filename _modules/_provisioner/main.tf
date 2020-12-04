variable "provisioner_name" {
  description = "The name of the new provisioner"
}

variable "auth_engine_path" {
  description = "The auth path to the auth engine to create teh provisioner in"
}

variable "ip_list" {
  description = "The IP Restrictions for the Provisioner"
  default = []
}

resource "vault_policy" "provisioner_policy" {
  name = var.provisioner_name
  policy = file("./_policies/${var.provisioner_name}")
}

output "provisioner-policy" {
  vaule = "Policy Created : ${var.provisioner_name}"
}

resource "vault_approle_auth_backend_role" "provisioner" {

  backend = var.auth_engine_path
  role_name = var.provisioner_name
  token_policies = ["default", var.provisioner_name]
  token_ttl = 120
  token_max_ttl = 120
  token_bound_cidrs = var.ip_list
}

output "provisioner-approle" {
  vaule = "Provisioner Created : ${var.provisioner_name}"
}
