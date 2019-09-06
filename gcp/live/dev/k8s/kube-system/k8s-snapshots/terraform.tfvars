# ↓ Module metadata
terragrunt = {
  terraform {
    source = "/project/modules//k8s-snapshots"
  }

  dependencies {
    paths = [
      "../helm-initializer",
      "../service-account-assigner",
      "../../gpii/couchdb-green",
      "../../gpii/couchdb-blue",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}
