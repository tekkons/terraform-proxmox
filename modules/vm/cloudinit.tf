resource "proxmox_virtual_environment_file" "cloudinit_config" {
  count = var.create_cloudinit_config ? 1 : 0

  content_type = var.cloudinit_content_type
  datastore_id = var.cloudinit_datastore_id
  node_name    = var.node_name

  source_raw {
    file_name = "${var.vm_id}-${var.hostname}-cloud-config.yaml"
    data = templatefile(
      "${path.module}/templates/cloud-config.yaml.tftpl", {
        hostname = var.hostname
        ssh_keys = var.ssh_keys
        packages = var.packages
      }
    )
  }
}
