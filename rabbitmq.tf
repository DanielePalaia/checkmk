# Install on first K8s cluster
resource "helm_release" "rabbitmq-cluster-1" {
  provider         = helm.cluster_1
  name             = local.common_config.name
  repository       = local.common_config.repository
  chart            = local.common_config.chart
  version          = local.common_config.version
  namespace        = local.common_config.namespace
  create_namespace = local.common_config.create_namespace

  wait = true

  # Apply common sets
  dynamic "set" {
    for_each = local.common_config.sets
    content {
      name  = set.key
      value = set.value
    }
  }

  # Apply cluster-specific sets
  dynamic "set" {
    for_each = local.cluster_1_config.sets
    content {
      name  = set.key
      value = set.value
    }
  }
}

# Install on second K8s cluster
resource "helm_release" "rabbitmq-cluster-2" {
  provider         = helm.cluster_2
  name             = local.common_config.name
  repository       = local.common_config.repository
  chart            = local.common_config.chart
  version          = local.common_config.version
  namespace        = local.common_config.namespace
  create_namespace = local.common_config.create_namespace
  wait             = true

  dynamic "set" {
    for_each = local.common_config.sets
    content {
      name  = set.key
      value = set.value
    }
  }

  # Apply cluster-specific sets
  dynamic "set" {
    for_each = local.cluster_2_config.sets
    content {
      name  = set.key
      value = set.value
    }
  }
}