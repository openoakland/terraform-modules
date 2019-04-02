module "iam_user" {
  source   = "../iam_user"
  username = "${var.username}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:ListBucket",
                "s3:DeleteObject"
            ],
            "Resource": [
              "${var.s3_bucket_arn}",
              "${var.s3_bucket_arn}/*"
            ]
        }
    ]
}
EOF
}
