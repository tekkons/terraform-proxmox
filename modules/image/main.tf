resource "proxmox_virtual_environment_download_file" "cloud_image" {
  for_each = { for img in var.images : img.file_name => img }

  content_type       = var.content_type
  datastore_id       = var.datastore_id
  node_name          = var.node_name
  file_name          = each.value["file_name"]
  url                = each.value["url"]
  checksum           = each.value["checksum"]
  checksum_algorithm = each.value["checksum_algorithm"]
}
