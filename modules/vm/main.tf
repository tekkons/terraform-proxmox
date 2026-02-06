resource "proxmox_virtual_environment_vm" "this" {
  node_name       = var.node_name
  name            = var.name
  vm_id           = var.vm_id
  description     = var.description
  tags            = var.tags
  scsi_hardware   = var.scsi_hardware
  boot_order      = var.boot_order
  on_boot         = var.on_boot
  protection      = var.protection
  started         = var.started
  stop_on_destroy = var.stop_on_destroy

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

    dynamic "dns" {
      for_each = var.dns != null ? [var.dns] : []
      content {
        domain  = dns.value["domain"]
        servers = dns.value["servers"]
      }
    }
  }

  dynamic "disk" {
    for_each = [var.disk]
    content {
      datastore_id = var.datastore_id
      file_id      = disk.value["file_id"]
      size         = disk.value["size"]
      interface    = lookup(disk.value, "interface", "scsi0")
      discard      = lookup(disk.value, "discard", "on")
      iothread     = lookup(disk.value, "iothread", true)
      ssd          = lookup(disk.value, "ssd", true)
      cache        = lookup(disk.value, "cache", "writeback")
    }
  }

  operating_system {
    type = var.operating_system_type
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
    timeout = "30"
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
