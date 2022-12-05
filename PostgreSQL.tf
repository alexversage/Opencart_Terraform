resource "yandex_mdb_postgresql_cluster" "opencart-cl01" {
  name                = "opencart-cl01"
  environment         = "PRODUCTION"
  network_id          = "yandex_vpc_network.network-1.id"
  security_group_ids  = ["yandex_vpc_security_group.pgsql-sg.id"]
  deletion_protection = false

  config {
    version = "14"
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 20
    }
  }

  host {
    zone      = var.zone
    subnet_id = yandex_vpc_subnet.subnet-1.id
  }
}

resource "yandex_mdb_postgresql_database" "opencart_db" {
  cluster_id = "yandex_mdb_postgresql_cluster.opencart-cl01.id"
  name       = "db1"
  owner      = "alex"
}

resource "yandex_mdb_postgresql_user" "alex" {
  cluster_id = "yandex_mdb_postgresql_cluster.opencart-cl01.id"
  name       = "postgres"
  password   = "12er324sdf2@D"
}
