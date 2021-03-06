resource "google_monitoring_alert_policy" "compute_firewalls_modify" {
  display_name = "GCE audit log does not contain firewall modification events"
  combiner     = "OR"

  conditions {
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/compute.firewalls.modify\" resource.type=\"global\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0.0
      duration        = "0s"

      aggregations {
        alignment_period   = "600s"
        per_series_aligner = "ALIGN_SUM"
      }

      denominator_filter = ""
    }

    display_name = "Firewall modification event found in GCE audit log"
  }

  documentation = {
    content   = "[Use this link to explore policy events in Logs Viewer](https://console.cloud.google.com/logs/viewer?project=${var.project_id}&minLogLevel=0&expandAll=false&interval=PT1H&advancedFilter=resource.type%3D%22gce_firewall_rule%22%20AND%20(protoPayload.methodName:%22compute.firewalls.insert%22%20OR%20protoPayload.methodName:%22compute.firewalls.patch%22%20OR%20protoPayload.methodName:%22compute.firewalls.update%22%20OR%20protoPayload.methodName:%22compute.firewalls.delete%22)"
    mime_type = "text/markdown"
  }

  notification_channels = ["${google_monitoring_notification_channel.email.name}", "${google_monitoring_notification_channel.alerts_slack.*.name}"]
  enabled               = "true"

  depends_on = ["google_logging_metric.compute_firewalls_modify"]
}
