variable "project_name" {
  description = "GCP project name"
}
variable "region" {
  description = "GCP region"
}
variable "network_name" {
  description = "GCP network name"
  default     = "default"
}
variable "instance_name" {
  description = "Instance name"
  default     = "vscode-server"
}
variable "machine_type" {
  description = "Instance type"
  default     = "e2-medium"
}
variable "gce_ssh_user" {
  description = "SSH user name"
}
variable "gce_ssh_pub_key_file" {
  description = "Path to PUBLIC ssh key"
  default     = "~/.ssh/id_rsa.pub"
}

