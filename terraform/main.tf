resource "docker_network" "app_network" {
  name = "app-network"
}

resource "docker_volume" "postgres_data" {
  name = "postgres-data"
}

resource "docker_container" "postgres" {
  name  = "postgres-db"
  image = "postgres:15"

  env = [
    "POSTGRES_DB=appdb",
    "POSTGRES_USER=appuser",
    "POSTGRES_PASSWORD=apppassword"
  ]

  networks_advanced {
    name = docker_network.app_network.name
  }

  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }
}

resource "docker_container" "web" {
  name  = "web-app"
  image = "custom-web-app:1.0"

  env = [
    "DB_HOST=postgres-db",
    "DB_NAME=appdb",
    "DB_USER=appuser",
    "DB_PASSWORD=apppassword",
    "APP_PORT=5000"
  ]

  networks_advanced {
    name = docker_network.app_network.name
  }
}

resource "docker_container" "nginx" {
  name  = "nginx-lb"
  image = "nginx:latest"

  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name = docker_network.app_network.name
  }
}
