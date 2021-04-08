resource "aws_iam_group" "sample_group_1" {
  name = "SampleGroup1"
}

resource "aws_iam_policy" "assume_role_policy_group_1" {
  name        = "SampleAssumeRolePolicyForSampleGroup1"
  description = "Allow group members to switch role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = var.assume_roles_sample_group_1
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "sample_group_1" {
  group      = aws_iam_group.sample_group_1.name
  policy_arn = aws_iam_policy.assume_role_policy_group_1.arn
}
