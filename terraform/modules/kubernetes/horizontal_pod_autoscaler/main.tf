resource "kubernetes_horizontal_pod_autoscaler" "hpa" {
  metadata {
    name = "hpa"
  }

  spec {
    max_replicas = 10
    min_replicas = 1

    target_cpu_utilization_percentage = 10

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "hpa-deploy-deployment"
    }
  }
}
