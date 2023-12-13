provider "helm" {
  kubernetes {
    host  = "https://${google_container_cluster.default.endpoint}"
    token = data.google_client_config.current.access_token
    client_certificate = base64decode(google_container_cluster.default.master_auth[0].client_certificate,)
    client_key = base64decode(google_container_cluster.default.master_auth[0].client_key)
    cluster_ca_certificate = base64decode(google_container_cluster.default.master_auth[0].cluster_ca_certificate,)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args = ["gke", "get-token", "--cluster-name", google_container_cluster.default.id]
      command = "google"
    }
  }
}

