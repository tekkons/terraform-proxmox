resource "proxmox_virtual_environment_vm" "this" {
  vm_id         = var.vm_id
  name          = var.hostname
  node_name     = var.node_name
  description   = var.description
  scsi_hardware = var.scsi_hardware
  boot_order    = var.boot_order
  on_boot       = var.on_boot
  protection    = var.protection
  tags          = var.tags

  cpu {
    cores = var.cpu_cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  network_device {
    bridge = var.network_device
  }

  initialization {
    datastore_id      = var.datastore_id
    user_data_file_id = var.create_cloudinit_config ? proxmox_virtual_environment_file.cloudinit_config[0].id : null

    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }
  }

  dynamic "disk" {
    for_each = var.disk != null ? [var.disk] : []
    content {
      datastore_id = var.datastore_id
      file_id      = disk.value["file_id"]
      interface    = disk.value["interface"]
      discard      = disk.value["discard"]
      iothread     = disk.value["iothread"]
      size         = disk.value["size"]
      ssd          = disk.value["ssd"]
      cache        = disk.value["cache"]
    }
  }

  operating_system {
    type = var.operating_system
  }

  agent {
    enabled = var.agent_enabled
    timeout = var.agent_timeout
  }

  serial_device {
    device = var.serial_device
  }

  vga {
    type = var.vga_type
  }

  lifecycle {
    ignore_changes = [
      initialization[0].user_data_file_id,
      disk[0].file_id,
      tags
    ]
  }

  depends_on = [
    proxmox_virtual_environment_file.cloudinit_config
  ]
}

resource "null_resource" "wait_for_cloudinit_configuration" {
  connection {
    type    = "ssh"
    user    = "root"
    host    = trimsuffix(proxmox_virtual_environment_vm.this.initialization[0].ip_config[0].ipv4[0].address, "/24")
    timeout = "15"
    agent   = true
  }

  provisioner "remote-exec" {
    inline = [
      "until [ -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for Cloud-Init...'; sleep 10; done"
    ]
  }

  depends_on = [
    proxmox_virtual_environment_vm.this
  ]
}
