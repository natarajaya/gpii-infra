terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "${get_env("TMPDIR", "/tmp/GPII_TMPDIR_WASNT_SET")}-modules//k8s"

    # Force Terraform to keep trying to acquire a lock for up to 1 minute if someone else already has the lock
    extra_arguments "retry_lock" {
      arguments = [
        "-lock-timeout=1m"
      ]
      commands = [
        "init",
        "apply",
        "refresh",
        "import",
        "plan",
        "taint",
        "untaint",
        "destroy"
      ]
    }
  }
}
