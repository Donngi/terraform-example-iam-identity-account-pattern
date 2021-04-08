resource "aws_iam_policy" "group_1_customer_managed" {
  name        = "Group1Policy"
  description = "Sample policy for group 1"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "group_2_customer_managed" {
  name        = "Group2Policy"
  description = "Sample policy for group 2"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:List*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
