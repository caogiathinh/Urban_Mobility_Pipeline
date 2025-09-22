variable "credentials" {
  description = "My credentials"
  default = "./keys/my-creds.json"
}

variable "project" {
    description = "Project"
    default     = "dataengineering-468103"
}

variable "region" {
    description = "Region"
    default     = "us-central1"
}

variable "location" {
    description = "Project location"
    default     = "US"
}

variable "dq_dataset_name" {
    description = "My BigQuery Dataset name"
    default     = "demo_dataset"
}

variable "gcs_bucket_name" {
    description = "My Storage Bucket Name"
    default     = "dataengineering-468103-terra-bucket"
}

variable "gcs_storage_class" {
    description = "GCS Storage Class"
    default     = "STANDARD"
}
