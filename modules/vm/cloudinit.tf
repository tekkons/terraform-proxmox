resource "proxmox_virtual_environment_file" "cloudinit_config" {
  count = var.create_cloudinit_config ? 1 : 0

  node_name    = var.node_name
  content_type = var.cloudinit_content_type
  datastore_id = var.cloudinit_datastore_id

  source_raw {
    data = templatefile(
      "${path.module}/templates/cloud-config.yaml.tftpl", {
        hostname = var.name
        ssh_keys = var.ssh_keys
        packages = var.packages
      }
    )

    file_name = format("%s%s", replace("cloud-config-${var.name}", ".", "-"), ".yaml")
  }
}
