provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = "${var.proxmox_token_id}=${var.proxmox_token_secret}"
  insecure  = var.proxmox_insecure

  ssh {
    agent    = var.proxmox_ssh_agent
    username = var.proxmox_ssh_username

    node {
      name    = var.proxmox_ssh_node_name
      address = var.proxmox_ssh_node_address
    }
  }
}

provider "null" {}
