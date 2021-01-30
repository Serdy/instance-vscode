terraform {
  required_version = ">= 0.14"
}
provider "google" {
  project = var.project_name
  region  = var.region
}