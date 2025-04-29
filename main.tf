# Install on first K8s cluster

resource "helm_release" "rabbitmq" {
  provider   = helm.cluster_1
  name       = "rabbitmq"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "rabbitmq"
  version    = "12.0.1"
  namespace  = "rabbitmq"
  create_namespace = true

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  # Credentials 
  set {
    name  = "auth.username"
    value = "admin"
  }
  set {
    name  = "auth.password"
    value = "password123"
  }

  set {
    name  = "service.ports.manager"
    value = "15672"  # RabbitMQ UI port
  }

  wait = true
}

# Install on second K8s cluster
#resource "helm_release" "rabbitmq" {
#  provider   = helm.cluster_2
#  name       = "rabbitmq"
#  repository = "https://charts.bitnami.com/bitnami"
#  chart      = "rabbitmq"
#  version    = "12.0.1"
#  namespace  = "rabbitmq"
#  create_namespace = true

  # Force LoadBalancer for local access
#  set {
#    name  = "service.type"
#    value = "LoadBalancer"
#  }

  # Credentials
#  set {
#    name  = "auth.username"
#    value = "admin"
#  }
#  set {
#    name  = "auth.password"
#    value = "password123"
#  }

#  wait = true
#}