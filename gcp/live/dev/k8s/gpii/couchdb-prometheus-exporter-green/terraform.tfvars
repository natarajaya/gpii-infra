# ↓ Module metadata
terragrunt = {
  terraform {
    source = "/project/modules//couchdb-prometheus-exporter"
  }

  dependencies {
    paths = [
      "../couchdb-blue",
      "../istio",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

couchdb_release_name = "couchdb-green"
