locals {
  tags = ["cloud-init", "terraform"]
  ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIP0DMQ..."
  ]
  packages = ["curl", "htop", "vim"]
}
