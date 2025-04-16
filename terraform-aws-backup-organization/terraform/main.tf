# Terraform module to manage the Organization backup policy in management account
module "backup-organization-policy" {
  source = "../backup-organization-policy"

  providers = { aws = aws.management }

  delegate_account_id = var.delegate_account_id
}

module "backup_policies" {
  source = "../central-backup-policy"

  providers = { aws = aws.delegate_backup_account }

  backup_plan_configuration = var.backup_plan_configuration

  depends_on = [module.backup-organization-policy]
}

module "workload-account-vault-ue1" {
  source = "../backup-vault"

  providers = { aws = aws.delegate_backup_account }

  vault_name = local.vault_name
}
