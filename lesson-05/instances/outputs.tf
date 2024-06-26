output "network_if" {
  value       = google_compute_instance.lesson_05.network_interface[0]
  description = "network"
}
