
resource "aws_iam_role" "example" {
  name               = "example"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.example.name
}


resource "aws_backup_vault" "ebs_backup_vault" {
  name     = "ebs_backup_vault"
}
#
resource "aws_backup_plan" "glpi_ebs_bkp_plan" {
  name = "glpi_ebs_bkp_plan"


  rule {
    rule_name         = "glpi_ebs_bkp_plan"
    target_vault_name = aws_backup_vault.ebs_backup_vault.name
    schedule          = "cron(0 17,23 * * ? *)"
    lifecycle {
      delete_after = "1"
    }

#### copy to another region vault ####
#   copy_action {
#      lifecycle {
#        delete_after = "1"
#      }
#      destination_vault_arn = aws_backup_vault.ebs_backup_vault.arn
#    }
  }
}

resource "aws_backup_selection" "example" {
  iam_role_arn = aws_iam_role.example.arn
  name         = "tf_example_backup_selection"
  plan_id      = aws_backup_plan.glpi_ebs_bkp_plan.id

  resources = [
    aws_ebs_volume.glpi_ebs.arn,
  ]
}

#resource "aws_backup_selection" "backup_selection_glpi" {
#  iam_role_arn = aws_iam_role.iam_role.arn
#  name         = "backup-selection-name-example"
#  plan_id      = aws_backup_plan.plan.id
#
#  selection_tag {
#    type  = "STRINGEQUALS"
#    key   = "Backup Policy"
#    value = "1-7-7"
#  }
#}
#resource "aws_backup_vault" "vault_local_useast1" {
#  provider = aws.useast1
#  name     = "ec2-us-east-1-vault"
#  #  kms_key_arn = aws_kms_key.example.arn
#}
#
#resource "aws_backup_vault" "vault_copy_eucentral1" {
#  provider = aws.eucentral1
#  name     = "ec2-dr-eu-central-1"
#  #  kms_key_arn = aws_kms_key.example.arn
#}
#resource "aws_backup_plan" "plan" {
#  name = "example"
#  # name = format("backup_plan_with_dr_%s", var.name)
#
#  advanced_backup_setting {
#    resource_type = "EC2"
#  }
#
#  rule {
#    rule_name         = "example rule"
#    target_vault_name = aws_backup_vault.vault_local_useast1.name
#    schedule          = "cron(0 8 * * ? *)"
#
#    lifecycle {
#      delete_after = "7"
#    }
#    copy_action {
#      lifecycle {
#        delete_after = "7"
#      }
#      destination_vault_arn = aws_backup_vault.vault_copy_eucentral1.arn
#    }
#  }
#  # tags = {
#  #   "environment" = "poc"
#  # }
#}
#
#
#resource "aws_backup_selection" "backup_selection" {
#  iam_role_arn = aws_iam_role.iam_role.arn
#  name         = "backup-selection-name-example"
#  plan_id      = aws_backup_plan.plan.id
#
#  selection_tag {
#    type  = "STRINGEQUALS"
#    key   = "Backup Policy"
#    value = "1-7-7"
#  }
#}