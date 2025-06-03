module "demo" {
  source = "./modules/vm"

  vm_id    = 100
  hostname = "demo"

  ssh_keys = local.ssh_public_keys
  packages = ["curl", "htop", "vim", "wget"]

  description = <<-EOT
    "Managed by Terraform"
  EOT

  tags = ["demo", "debian12", "cloud-init", "terraform"]

  cpu_cores = 1
  cpu_type  = "x86-64-v2"
  memory    = "1024"

  disk = {
    file_id   = module.images.image_ids[0]
    interface = "scsi0"
    discard   = "on"
    iothread  = "true"
    size      = 16
    ssd       = true
    cache     = "writeback"
  }

  ipv4_address = "192.168.1.10"
  ipv4_gateway = "192.168.1.1"

  ssh_private_key_file = local.ssh_private_key_file
}
