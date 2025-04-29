locals {
  rabbitmq_chart_version = "12.0.1"
  rabbitmq_namespace     = "rabbitmq-system"
  repository             = "https://charts.bitnami.com/bitnami"
  chart                  = "rabbitmq"
  
  # Define common configuration
  common_config = {
    name             = "rabbitmq"
    repository       = local.repository
    chart            = local.chart
    version          = local.rabbitmq_chart_version
    namespace        = local.rabbitmq_namespace
    create_namespace = true
    
    # Common sets
    sets = {
      "auth.username" = "admin"
      "auth.password" = "password123"
      "service.type"  = "NodePort"
    }
  }
  
  # Cluster-specific configs
  cluster_1_config = {
    sets = {
      "service.ports.manager" = "15672"  # RabbitMQ UI port
    }
  }
  
  cluster_2_config = {
    sets = {}  # No additional settings for cluster 2
  }
}