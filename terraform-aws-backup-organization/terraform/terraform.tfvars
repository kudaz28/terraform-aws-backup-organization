backup_plan_configuration = {
  policy_1 = {
    delegate_account_id        = 703171089145
    name                       = "daily-backup"
    backup_cron_schedule       = "cron(0 2 * * ? *)"
    vault_name                 = "daily-vault"
    start_window_minutes       = 60
    completion_window          = 360
    delete_after_days        = 270
    cold_storage_after_days         = 90
    backup_selection_role_name = "backup-role"
    backup_selection_tags = {
      My_Backup_Assignment = {
        tag_key   = "dataType"
        tag_value = ["PII", "RED"]
      }
    }
    secondary_vault_region = "eu-west-2"
    target_resource_region = "eu-west-2"
  }
}

vault_name          = "daily-backup"
delegate_account_id = "703171089145"
