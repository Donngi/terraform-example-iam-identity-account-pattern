resource "aws_iam_policy" "customer_managed" {
  name        = "UserDirectAttachPolicy"
  description = "Sample policy for sample user who attached policy directly"

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
