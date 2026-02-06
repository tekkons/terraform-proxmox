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

variable "ssh_keys" {
  type    = list(string)
  default = []
}

variable "packages" {
  type    = list(string)
  default = []
}

variable "node_name" {
  type    = string
  default = "proxmox"
}

variable "name" {
  type = string
}

variable "vm_id" {
  type = number
}

variable "description" {
  type    = string
  default = <<-EOT
    Managed by Terraform<br>
    <br>
  EOT
}

variable "tags" {
  type    = list(string)
  default = ["cloud-init", "terraform"]
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
  default = false
}

variable "started" {
  type    = bool
  default = true
}

variable "stop_on_destroy" {
  type    = bool
  default = true
}

variable "cpu_cores" {
  type    = number
  default = 1
}

variable "cpu_type" {
  type    = string
  default = "host"
}

variable "memory" {
  type    = number
  default = 512
}

variable "network_device" {
  type    = string
  default = "vmbr0"
}

variable "ipv4_address" {
  type = string
}

variable "ipv4_gateway" {
  type = string
}

variable "dns" {
  type    = any
  default = null
}

variable "datastore_id" {
  type    = string
  default = "vms"
}

variable "disk" {
  type = map(string)
}

variable "operating_system_type" {
  type    = string
  default = "l26"
}

variable "agent_enabled" {
  type    = bool
  default = true
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
