provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = "${var.proxmox_token_id}=${var.proxmox_token_secret}"
  insecure  = var.proxmox_insecure

  ssh {
    username = var.proxmox_username
    agent    = var.proxmox_agent
  }
}

provider "null" {}
