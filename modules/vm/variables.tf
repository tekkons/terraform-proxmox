variable "create_cloudinit_config" {
  type    = bool
  default = true
}

variable "cloudinit_content_type" {
  type    = string
  default = "snippets"
}

variable "cloudinit_datastore_id" {
  type    = string
  default = "local"
}

variable "node_name" {
  type    = string
  default = "proxmox"
}

variable "ssh_keys" {
  type = list(string)
}

variable "packages" {
  type = list(string)
}

variable "vm_id" {
  type = number
}

variable "hostname" {
  type = string
}

variable "description" {
  type    = string
  default = "Managed by Terraform"
}

variable "scsi_hardware" {
  type    = string
  default = "virtio-scsi-single"
}

variable "boot_order" {
  type    = list(string)
  default = ["scsi0"]
}

variable "on_boot" {
  type    = bool
  default = true
}

variable "protection" {
  type    = bool
  default = true
}

variable "tags" {
  type    = list(string)
  default = ["cloud-init", "terraform"]
}

variable "cpu_cores" {
  type = number
}

variable "cpu_type" {
  type = string
}

variable "memory" {
  type = number
}

variable "network_device" {
  type    = string
  default = "vmbr0"
}

variable "datastore_id" {
  type    = string
  default = "vms"
}

variable "ipv4_address" {
  type = string
}

variable "ipv4_gateway" {
  type = string
}

variable "disk" {
  type = map(string)
}

variable "operating_system" {
  type    = string
  default = "l26"
}

variable "agent_enabled" {
  type    = string
  default = "true"
}

variable "agent_timeout" {
  type    = string
  default = "2m"
}

variable "serial_device" {
  type    = string
  default = "socket"
}

variable "vga_type" {
  type    = string
  default = "serial0"
}

variable "ssh_private_key_file" {
  type = string
}