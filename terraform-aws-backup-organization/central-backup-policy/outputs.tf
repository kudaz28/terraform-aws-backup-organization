output "policy" {
  value = {
    for k in keys(aws_organizations_policy.backup) :
    k => aws_organizations_policy.backup[k].content
  }
}