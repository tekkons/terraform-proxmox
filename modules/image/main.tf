resource "proxmox_virtual_environment_download_file" "cloud_image" {
  for_each = { for k, v in var.images : format("%s", k) => v }

  content_type       = var.content_type
  datastore_id       = var.datastore_id
  node_name          = var.node_name
  file_name          = each.value["file_name"]
  url                = each.value["url"]
  checksum           = lookup(each.value, "checksum", null)
  checksum_algorithm = lookup(each.value, "checksum_algorithm", null)
}
