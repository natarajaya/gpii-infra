image:
  repository: ${service_account_assigner_repository}
  checksum: ${service_account_assigner_checksum}

defaultServiceAccount: "${ default_service_account }"
# See https://cloud.google.com/sdk/gcloud/reference/beta/compute/instances/set-scopes
defaultScopes:
- https://www.googleapis.com/auth/cloud-platform
