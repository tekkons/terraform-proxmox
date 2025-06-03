variable "images" {
  type = list(object({
    file_name          = string
    url                = string
    checksum           = optional(string)
    checksum_algorithm = optional(string)
  }))
}

variable "content_type" {
  type    = string
  default = "iso"
}

variable "datastore_id" {
  type    = string
  default = "local"
}

variable "node_name" {
  type    = string
  default = "proxmox"
}
