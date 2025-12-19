resource "proxmox_virtual_environment_file" "cloudinit_config" {
  count = var.create_cloudinit_config ? 1 : 0

  content_type = var.cloudinit_content_type
  datastore_id = var.cloudinit_datastore_id
  node_name    = var.node_name

  source_raw {
    data = templatefile(
      "${path.module}/templates/cloud-config.yaml.tftpl", {
        hostname = var.hostname
        ssh_keys = var.cloudinit_ssh_keys
        packages = var.cloudinit_packages
      }
    )

    file_name = format("%s%s", replace("cloud-config-${var.hostname}", ".", "-"), ".yaml")
  }
}
