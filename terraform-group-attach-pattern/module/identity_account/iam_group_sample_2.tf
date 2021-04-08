resource "aws_iam_group" "sample_group_2" {
  name = "SampleGroup2"
}

resource "aws_iam_policy" "assume_role_policy_group_2" {
  name        = "SampleAssumeRolePolicyForSampleGroup2"
  description = "Allow group members to switch role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = var.assume_roles_sample_group_2
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "sample_group_2" {
  group      = aws_iam_group.sample_group_2.name
  policy_arn = aws_iam_policy.assume_role_policy_group_2.arn
}
