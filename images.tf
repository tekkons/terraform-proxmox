module "images" {
  source = "./modules/image"

  images = yamldecode(file("${path.module}/images.yaml"))
}
