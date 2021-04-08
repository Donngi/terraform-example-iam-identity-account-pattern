# How to use

## Set up
Set your IAM roles in `./envs/example/aws.tf`.

```
provider "aws" {
  alias = "account-identity"
  assume_role {
    role_arn = "YOUR_ROLE_FOR_IDENTITY_ACCOUNT" # FIXME
  }
  region = "ap-northeast-1"
}

provider "aws" {
  alias = "account-a"
  assume_role {
    role_arn = "YOUR_ROLE_FOR_ACCOUNT_A" #FIXME
  }
  region = "ap-northeast-1"
}

provider "aws" {
  alias = "account-b"
  assume_role {
    role_arn = "YOUR_ROLE_FOR_ACCOUNT_B" #FIXME
  }
  region = "ap-northeast-1"
}
```

Execute terraform commands at `./envs/example`.

```
$ terraform init
$ terraform apply
```

## Add new IAM user
Add new IAM user to identity-account (`./module/identity_account`).

```
Add new .tf file with reference to iam_user_sample_user.tf
```

## Add new AWS account
Add new provider (`./envs/example/aws.tf`).

```
provider "aws" {
  alias = "account-new"
  assume_role {
    role_arn = "YOUR_ROLE_FOR_ACCOUNT_NEW" #FIXME
  }
  region = "ap-northeast-1"
}
```

Add new module directory associated with new AWS account (`./module`).

```
Add new module (=directory) with reference to ./module/account_a
```

Add new account (`./envs/main.tf`).

```
module "account_new" {
  providers = {
    aws = "aws.account-new"
  }
  source              = "../../module/account_new"
  identity_account_id = data.aws_caller_identity.identity.account_id
}
```

Add new role for each user (`./envs/example/main.tf`).

```
module "identity_account" {
  providers = {
    aws = "aws.account-identity"
  }
  source = "../../module/identity_account"
  assume_roles_sample_user = [
    module.account_a.iam_role_for_sample_user.arn,
    module.account_b.iam_role_for_sample_user.arn  # Add here!
  ]
}
```
