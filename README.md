# terraform-example-iam-identity-account-pattern
Example of AWS identity account pattern.

The identity account pattern is one of design pattern of multiple AWS accounts. Users logs in to only single account called 'Identity account' and use assume role (switch role) api to access other accounts.

This pattern has two types of policy attachment strategy. One is `IAM user direct attach pattern` which attaches IAM policy directry to IAM user. Another is `IAM group attach pattern` which attaches IAM policy to IAM Group and all IAM users belong to them.

## IAM user direct attach pattern
![IAM user direct attach pattern](./doc/architecture-iam-user-direct-attach-pattern.drawio.svg)

```
terraform-user-direct-attach-pattern
├── README.md
├── envs
│   └── example
│       ├── aws.tf
│       └── main.tf
└── module
    ├── account_a
    │   ├── iam_policy_customer_managed.tf
    │   ├── iam_role_for_sample_user.tf
    │   ├── output.tf
    │   └── variables.tf
    ├── account_b
    │   ├── iam_policy_customer_managed.tf
    │   ├── iam_role_for_sample_user.tf
    │   ├── output.tf
    │   └── variables.tf
    └── identity_account
        ├── iam_user_sample_user.tf
        └── variables.tf
```

## IAM group attach pattern
![IAM group attach pattern](./doc/architecture-iam-group-attach-pattern.drawio.svg)

```
terraform-group-attach-pattern
├── README.md
├── envs
│   └── example
│       ├── aws.tf
│       └── main.tf
└── module
    ├── account_a
    │   ├── iam_policy_customer_managed.tf
    │   ├── iam_role_for_group_1.tf
    │   ├── iam_role_for_group_2.tf
    │   ├── output.tf
    │   └── variables.tf
    ├── account_b
    │   ├── iam_policy_customer_managed.tf
    │   ├── iam_role_for_group_1.tf
    │   ├── iam_role_for_group_2.tf
    │   ├── output.tf
    │   └── variables.tf
    └── identity_account
        ├── iam_group_sample_1.tf
        ├── iam_group_sample_2.tf
        ├── iam_user.tf
        └── variables.tf
```
