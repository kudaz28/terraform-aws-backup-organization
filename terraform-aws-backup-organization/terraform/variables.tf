variable "backup_plan_configuration" {
  type = map(object({
    delegate_account_id     = string
    name                    = string
    backup_cron_schedule    = string
    vault_name              = string
    start_window_minutes    = number
    completion_window       = number
    delete_after_days     = number
    cold_storage_after_days      = number
    backup_selection_role_name = string
    backup_selection_tags = map(object({
      tag_key   = string
      tag_value = list(string)
    }))
    secondary_vault_region  = string
    target_resource_region  = string
  }))
}

variable "vault_name" {
  type        = string
  description = "Unique name for the backup vault"
  default     = "aws_backup_vault"
}

variable "delegate_account_id" {
  description = "AWS account id for the delagate backup account"
  type        = string
}


