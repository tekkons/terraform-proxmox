module "demo" {
  source = "./modules/vm"

  vm_id    = 100
  hostname = "demo"

  cloudinit_ssh_public_keys = local.ssh_public_keys
  cloudinit_common_tools    = ["curl", "htop", "vim", "wget"]

  description = <<-EOT
    "Managed by Terraform"
  EOT

  tags = ["demo", "debian13", "cloud-init", "terraform"]

  cpu_cores = 1
  memory    = 1024

  disk = {
    file_id   = module.images.image_ids["debian13"]
    interface = "scsi0"
    discard   = "on"
    iothread  = "true"
    size      = 16
    ssd       = true
    cache     = "writeback"
  }

  ipv4_address = "192.168.1.10/24"
  ipv4_gateway = "192.168.1.1"

  dns = {
    "domain"  = "example.com"
    "servers" = ["1.1.1.1", "8.8.8.8"]
  }
}
