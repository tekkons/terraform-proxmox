variable "proxmox_endpoint" {
  type = string
}

variable "proxmox_token_id" {
  type = string
}

variable "proxmox_token_secret" {
  type = string
}

variable "proxmox_insecure" {
  type    = bool
  default = true
}

variable "proxmox_ssh_agent" {
  type    = bool
  default = true
}

variable "proxmox_ssh_username" {
  type    = string
  default = "root"
}

variable "proxmox_ssh_node_name" {
  type    = string
  default = "proxmox"
}

variable "proxmox_ssh_node_address" {
  type = string
}
