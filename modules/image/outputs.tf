output "image_ids" {
  value = [for img in proxmox_virtual_environment_download_file.cloud_image : img.id]
}
