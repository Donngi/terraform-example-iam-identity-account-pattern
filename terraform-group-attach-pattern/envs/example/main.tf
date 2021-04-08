data "aws_caller_identity" "identity" {
  provider = aws.account-identity
}

module "identity_account" {
  providers = {
    aws = "aws.account-identity"
  }
  source = "../../module/identity_account"
  assume_roles_sample_group_1 = [
    module.account_a.iam_role_for_group_1.arn,
    module.account_b.iam_role_for_group_1.arn
  ]
  assume_roles_sample_group_2 = [
    module.account_a.iam_role_for_group_2.arn,
    module.account_b.iam_role_for_group_2.arn
  ]
}

module "account_a" {
  providers = {
    aws = "aws.account-a"
  }
  source              = "../../module/account_a"
  identity_account_id = data.aws_caller_identity.identity.account_id
}

module "account_b" {
  providers = {
    aws = "aws.account-b"
  }
  source              = "../../module/account_b"
  identity_account_id = data.aws_caller_identity.identity.account_id
}
