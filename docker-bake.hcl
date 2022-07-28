group "default" {
    targets = ["image"]
  }
  
  variable "TAG" {
    default = "latest"
  }
  
  target "tag" {
    tags = ["stlouisn/ubuntu:${TAG}"]
  }
  
  target "image" {
    inherits = ["tag"]
    context = "."
    dockerfile = "dockerfile"
    labels = {
      "org.opencontainers.image.title" = "ubuntu"
      "org.opencontainers.image.ref" = "website_here"
    }
  }
  
  target "image-all" {
    inherits = ["image"]
    platforms = [ "linux/amd64", "linux/arm/v6", "linux/arm/v7", "linux/arm64" ]
  }