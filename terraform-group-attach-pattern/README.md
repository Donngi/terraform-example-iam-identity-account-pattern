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

If you don't want to manage IAM users with terraform, remove the IAM file (`./module/identity_account/iam_user.tf`).

```
$ rm ./module/identity_account/iam_user.tf
```

Execute terraform commands at `./envs/example`.

```
$ terraform init
$ terraform apply
```

## Add new group
Add new IAM Group to identity-account (`./module/identity_account`).

```
Add new .tf file with reference to iam_group_sample_1.tf
```

Add new IAM role for new group to each AWS account, such as account-a and account-b (`./module/account_a`).

```
Add new .tf file with reference to iam_role_for_group_1.tf
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

Add new role for each group (`./envs/example/main.tf`).

```
module "identity_account" {
  providers = {
    aws = "aws.account-identity"
  }
  source = "../../module/identity_account"
  assume_roles_sample_group_1 = [
    module.account_a.iam_role_for_group_1.arn # Add here!
  ]
  assume_roles_sample_group_2 = [
    module.account_a.iam_role_for_group_2.arn # Add here!
  ]
}
```

## Add new IAM user
Add new IAM user (`./module/identity_account/iam_user.tf`).

```
resource "aws_iam_user" "new_user_group_1" {
  name = "NewUserGroup1"
}

resource "aws_iam_user_group_membership" "new_user_group_1" {
  user = aws_iam_user.new_user_group_1.name

  groups = [
    aws_iam_group.sample_group_1.name,
  ]
}
```

