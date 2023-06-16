resource "azurerm_resource_group" "rg" {
  name     = "Mini-Project"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

resource "null_resource" "apply_manifests" {
  depends_on = [azurerm_kubernetes_cluster.aks]

  provisioner "local-exec" {
    command     = "kubectl apply -f /home/ubuntu/webapp/deployments"
    working_dir = "/home/ubuntu/webapp"
  }
}

resource "null_resource" "kubeconfig" {
  depends_on = [azurerm_kubernetes_cluster.aks]

  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ~/.kube
      az aks get-credentials --name ${azurerm_kubernetes_cluster.aks.name} --resource-group ${azurerm_resource_group.rg.name}
    EOT
  }
}
