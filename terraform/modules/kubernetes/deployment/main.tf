resource "kubernetes_deployment" "hpa-deployment" {
  metadata {
    name = "hpa-deploy-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "hpa-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "hpa-app"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"

          resources {
            limits = {
              cpu    = "50m"
              memory = "100Mi"
            }
            requests = {
              cpu    = "25m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
