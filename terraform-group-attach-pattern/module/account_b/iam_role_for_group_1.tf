resource "aws_iam_role" "for_group_1" {
  name = "AssumeRoleGroup1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::${var.identity_account_id}:root"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "group_1_customer_managed" {
  role       = aws_iam_role.for_group_1.name
  policy_arn = aws_iam_policy.group_1_customer_managed.arn
}

resource "aws_iam_role_policy_attachment" "group_1_aws_managed" {
  role       = aws_iam_role.for_group_1.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
