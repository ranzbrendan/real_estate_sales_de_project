terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.5.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_storage_bucket" "personal_project_bucket" {
  name                        = var.gcs_bucket_name
  location                    = var.location
  force_destroy               = true
  storage_class               = var.gcs_storage_class
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "personal_project_dataset" {
  dataset_id  = var.bigquery_dataset_name
  description = "Real Estates Project dataset"
  location    = var.region
}