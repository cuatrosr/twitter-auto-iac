resource "kubernetes_service" "hpa-service" {
  metadata {
    name = "hpa-deploy-service"
  }

  spec {
    selector = {
      app = "hpa-app"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}
