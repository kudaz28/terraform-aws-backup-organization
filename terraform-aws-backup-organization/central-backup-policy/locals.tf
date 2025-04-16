locals {

  parent_roots_id = data.aws_organizations_organization.org.roots[0].id

  generated_backup_policies = {
    for map_key, config in var.backup_plan_configuration :
    map_key => {
      rules = {
        "${config.name}-rule" = {
          target_backup_vault_name = {
            "@@assign" = config.vault_name
          }
          schedule_expression = {
            "@@assign" = config.backup_cron_schedule
          }
          start_backup_window_minutes = {
            "@@assign" = config.start_window_minutes
          }
          complete_backup_window_minutes = {
            "@@assign" = config.completion_window
          }
          lifecycle = {
            delete_after_days = config.delete_after_days
            move_to_cold_storage_after_days = config.cold_storage_after_days
          }
          backup_copy_actions = {
            "arn:aws:backup:${config.secondary_vault_region}:$account:backup-vault:${config.vault_name}" = {
            target_backup_vault_arn = {
                "@@assign" = "arn:aws:backup:${config.secondary_vault_region}:$account:backup-vault:${config.vault_name}"
            }
            lifecycle = {
                delete_after_days = config.delete_after_days
                move_to_cold_storage_after_days = config.cold_storage_after_days
            }
            },
            "arn:aws:backup:${config.target_resource_region}:${data.aws_caller_identity.current.account_id}:backup-vault:${config.vault_name}" = {
            target_backup_vault_arn = {
                "@@assign" = "arn:aws:backup:${config.target_resource_region}:${data.aws_caller_identity.current.account_id}:backup-vault:${config.vault_name}"
            }
            lifecycle = {
                delete_after_days = config.delete_after_days
                move_to_cold_storage_after_days = config.cold_storage_after_days
            }
            },
          }
        }
      }
      regions = {
        "@@append" = [
            config.target_resource_region
        ]
      },
      selections = {
        tags = {
          for label, tag_config in config.backup_selection_tags :
          label => {
            iam_role_arn = {
              "@@assign" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${config.backup_selection_role_name}"
            },
            tag_key = {
              "@@assign" = tag_config.tag_key
            },
            tag_value = {
              "@@assign" = tag_config.tag_value
            }
          }
        }
      }
      advanced_backup_setting = {
        ec2 = {
            windows_vss = {
                "@@assign" = "enabled"
            }
        }
      }
    }
  }
}
