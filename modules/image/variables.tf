variable "images" {
  type = map(map(string))
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
