resource "aws_iam_user" "main" {
  name = var.username
}

resource "aws_iam_access_key" "main" {
  user = aws_iam_user.main.name
}

resource "aws_iam_user_policy" "main" {
  name   = aws_iam_user.main.name
  user   = aws_iam_user.main.name
  policy = var.policy
}

