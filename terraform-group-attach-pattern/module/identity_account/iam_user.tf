resource "aws_iam_user" "sample_user_group_1" {
  name = "SampleUserGroup1"
}

resource "aws_iam_user_group_membership" "sample_user_group_1" {
  user = aws_iam_user.sample_user_group_1.name

  groups = [
    aws_iam_group.sample_group_1.name,
  ]
}

resource "aws_iam_user" "sample_user_group_2" {
  name = "SampleUserGroup2"
}

resource "aws_iam_user_group_membership" "sample_user_group_2" {
  user = aws_iam_user.sample_user_group_2.name

  groups = [
    aws_iam_group.sample_group_2.name,
  ]
}

