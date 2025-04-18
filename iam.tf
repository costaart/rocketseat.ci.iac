resource "aws_iam_openid_connect_provider" "oidc-git" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["1b511abead59c6ce207077c0bf0e0043b1382612"]

  tags = {
    IAC = "True"
  }
}

resource "aws_iam_role" "tf-role" {
  name = "tf-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Principal" : {
          "Federated" : "arn:aws:iam::651706743475:oidc-provider/token.actions.githubusercontent.com"
        },
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : ["sts.amazonaws.com"],
            "token.actions.githubusercontent.com:sub" : ["repo:costaart/rocketseat.ci.iac:ref:refs/heads/main"]
          }
        }
      }
    ]
  })

  tags = {
    IAC = "True"
  }
}

resource "aws_iam_role_policy" "tf_permissions" {
  name = "tf-permissions"
  role = aws_iam_role.tf-role.name
  policy = jsonencode({
    Statement = [
      {
        Sid      = "Statement1",
        Action   = "ecr:*",
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Sid      = "Statement2",
        Action   = "iam:*",
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Sid      = "Statement3"
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
