provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::881670337532:role/Admin"
    session_name = "EC2"
    external_id  = "111"
  }

  region  = "us-east-1"
  profile = "default"
}

resource "aws_s3_bucket" "Artefactory" {
  bucket = "kranthi1234554321"
  acl    = "public-read"
  provisioner "local-exec" {
    command = "echo ${aws_s3_bucket.Artefactory.arn} >> arn"
    command = "echo ${aws_s3_bucket.Artefactory.id} >> id"
      }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "Artefactory" {
  bucket = "${aws_s3_bucket.Artefactory.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1566380613035",
    "Statement": [
        {
            "Sid": "Stmt1566380610508",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "${aws_s3_bucket.Artefactory.arn}"
        }
    ]
}
POLICY
}
