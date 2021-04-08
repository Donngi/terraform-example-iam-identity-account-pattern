resource "aws_iam_role" "for_sample_user" {
  name = "AssumeRoleForSampleUser"

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

resource "aws_iam_role_policy_attachment" "customer_managed" {
  role       = aws_iam_role.for_sample_user.name
  policy_arn = aws_iam_policy.customer_managed.arn
}

resource "aws_iam_role_policy_attachment" "aws_managed" {
  role       = aws_iam_role.for_sample_user.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
