terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
   backend "s3" {
    bucket = "day-02-sivanithin-backend"
    key = "terraform-backend"
  }
 
}
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_s3_bucket" "nithin_website" {
  bucket = var.bucket_name

  tags = {
    Name = "nithin Website Bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "nithin_website" {
  bucket = aws_s3_bucket.nithin_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.nithin_website.id

  index_document {
    suffix = "index.html"
  }

  depends_on = [aws_s3_bucket_public_access_block.nithin_website]
}

data "aws_iam_policy_document" "public_read_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.nithin_website.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.nithin_website.id
  policy = data.aws_iam_policy_document.public_read_policy.json
}

resource "aws_s3_object" "html_file" {
  bucket       = aws_s3_bucket.nithin_website.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
}
