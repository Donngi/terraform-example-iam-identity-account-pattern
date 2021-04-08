data "aws_caller_identity" "identity" {
  provider = aws.account-identity
}

module "identity_account" {
  providers = {
    aws = "aws.account-identity"
  }
  source = "../../module/identity_account"
  assume_roles_sample_user = [
    module.account_a.iam_role_for_sample_user.arn,
    module.account_b.iam_role_for_sample_user.arn
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
