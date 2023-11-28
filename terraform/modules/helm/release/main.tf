resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stackr"
  namespace  = "kube-public"
  version    = "36.2.0"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
}
