resource "google_monitoring_alert_policy" "dns_modify" {
  display_name = "CloudDNS audit log does not contain zone modification events"
  combiner     = "OR"
  depends_on   = ["null_resource.wait_for_lbms"]

  conditions {
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.dns_modify.name}\" resource.type=\"dns_managed_zone\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0.0
      duration        = "0s"

      aggregations {
        alignment_period   = "600s"
        per_series_aligner = "ALIGN_SUM"
      }

      denominator_filter = ""
    }

    display_name = "Zone modification modification event found in CloudDNS audit log"
  }

  documentation = {
    content   = "[Use this link to explore policy events in Logs Viewer](https://console.cloud.google.com/logs/viewer?project=${var.project_id}&minLogLevel=0&expandAll=false&interval=PT1H&advancedFilter=resource.type%3D%22dns_managed_zone%22%20AND%20(protoPayload.methodName%3D%22dns.changes.create%22%20OR%20protoPayload.methodName%3D%22dns.managedZones.delete%22%20OR%20protoPayload.methodName%3D%22dns.managedZones.patch%22%20OR%20protoPayload.methodName%3D%22dns.managedZones.update%22)"
    mime_type = "text/markdown"
  }

  notification_channels = ["${google_monitoring_notification_channel.email.name}", "${google_monitoring_notification_channel.alerts_slack.*.name}"]
  enabled               = "true"
}
