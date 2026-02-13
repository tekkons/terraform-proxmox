module "demo" {
  source = "./modules/vm"

  name  = "demo"
  vm_id = 100
  tags  = concat(["demo", "debian13"], local.tags)

  ssh_keys = local.ssh_keys
  packages = local.packages

  cpu_cores    = 1
  memory       = 1024
  ipv4_address = "192.168.1.10/24"
  ipv4_gateway = "192.168.1.1"

  dns = {
    "domain"  = "example.com"
    "servers" = ["1.1.1.1", "8.8.8.8"]
  }

  disk = {
    file_id = module.images.image_ids["debian13"]
    size    = 16
  }
}
