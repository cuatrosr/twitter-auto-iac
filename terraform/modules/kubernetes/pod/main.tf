resource "kubernetes_pod" "load-generator" {
  metadata {
    name = "load-generator"
  }

  spec {
    container {
      name    = "load-generator"
      image   = "busybox:1.28"
      command = ["/bin/sh", "-c"]
      args    = ["while sleep 0.01; do wget -q -O- http://hpa-deploy-service; done"]
    }
    restart_policy = "Never"
  }
}
