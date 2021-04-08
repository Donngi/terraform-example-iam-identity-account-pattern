resource "aws_iam_user" "sample_user" {
  name = "SampleUserAttachedPolicyDirectly"
}

resource "aws_iam_policy" "assume_role_policy" {
  name        = "SampleAssumeRolePolicyForIndivisualUsers"
  description = "Allow users to switch role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = var.assume_roles_sample_user
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "sample_user" {
  user       = aws_iam_user.sample_user.name
  policy_arn = aws_iam_policy.assume_role_policy.arn
}
