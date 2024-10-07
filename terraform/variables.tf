variable "project" {
  description = "Project"
  default     = "crack-celerity-435208-v5"
}

variable "region" {
  description = "Region"
  default     = "asia-southeast1"
}

variable "location" {
  description = "Location"
  default     = "ASIA"
}

variable "bigquery_dataset_name" {
  description = "BigQuery Dataset Name"
  default     = "real_estate_sales_db"
}

variable "gcs_bucket_name" {
  description = "Storage Bucket Name"
  default     = "real_estates_project"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}