resource "yandex_kubernetes_cluster" "opencart-k8s" {
  network_id = yandex_vpc_network.network-1.id
  master {
    zonal {
      zone      = yandex_vpc_subnet.subnet-1.zone
      subnet_id = yandex_vpc_subnet.subnet-1.id
    }
  }
  service_account_id      = var.service_account_id
  node_service_account_id = var.service_account_id
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.editor,
    yandex_resourcemanager_folder_iam_binding.images-puller
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  # Сервисному аккаунту назначается роль "editor".
  folder_id = var.folder_id
  role      = "editor"
  members = [
    "serviceAccount:${var.service_account_id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${var.service_account_id}"
  ]
}
