output "rabbitmq_cluster_1_status" {
  description = "Connection details for RabbitMQ on Cluster 1"
  value = {
    namespace = helm_release.rabbitmq-cluster-1.namespace
    version   = helm_release.rabbitmq-cluster-1.version
    ui_endpoint = try(
      "http://${helm_release.rabbitmq-cluster-1.name}.${helm_release.rabbitmq-cluster-1.namespace}.svc.cluster.local:15672",
      "UI port not exposed"
    )
    credentials = {
      username = local.common_config.sets["auth.username"]
      password = sensitive(local.common_config.sets["auth.password"])
    }

  }
  sensitive = true
}

output "rabbitmq_cluster_2_status" {
  description = "Connection details for RabbitMQ on Cluster 2"
  value = {
    namespace = helm_release.rabbitmq-cluster-2.namespace
    version   = helm_release.rabbitmq-cluster-2.version
    ui_endpoint = try(
      "http://${helm_release.rabbitmq-cluster-2.name}.${helm_release.rabbitmq-cluster-2.namespace}.svc.cluster.local:15672",
      "UI port not exposed"
    )
    credentials = {
      username = local.common_config.sets["auth.username"]
      password = sensitive(local.common_config.sets["auth.password"])
    }
  }
  sensitive = true # Hide entire output if credentials are exposed
}