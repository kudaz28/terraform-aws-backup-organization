/*resource "aws_organizations_policy" "this" {

  for_each = var.backup_plan_configuration

  name    = "${each.key}-policy"
  type    = "BACKUP_POLICY"
  content = jsonencode(local.backup_plans)
  description = "${each.key}-policy"
}*/

resource "aws_organizations_policy" "backup" {
  for_each = local.generated_backup_policies

  name    = "${each.key}-policy"
  type    = "BACKUP_POLICY"
  content = jsonencode({
    plans = {
      "${each.key}" = each.value
    }
  })
}


resource "aws_organizations_policy_attachment" "this" {

  for_each  = aws_organizations_policy.backup
  
  policy_id = each.value.id
  target_id = local.parent_roots_id
}
