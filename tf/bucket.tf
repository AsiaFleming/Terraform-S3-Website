#create s3 bucket 
resource "aws_s3_bucket" "asia-static-bucket-tf" {
  bucket = var.bucketname
}

#Disable ACLs and enforce bucket ownership
resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.asia-static-bucket-tf.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
#Configure public access settings
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.asia-static-bucket-tf.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

#Upload index.html and error.html files to the bucket
resource "aws_s3_object" "index" {
    bucket = aws_s3_bucket.asia-static-bucket-tf.id
    key    = "index.html"
    source = "index.html"
    content_type = "text/html"
}

resource "aws_s3_object" "error" {
    bucket = aws_s3_bucket.asia-static-bucket-tf.id
    key    = "error.html"
    source = "error.html"
    content_type = "text/html"
  
}
#Configure the bucket for website hosting
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.asia-static-bucket-tf.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

data "aws_iam_policy_document" "public_read" {
  statement {
    sid     = "PublicReadGetObject"
    effect  = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.asia-static-bucket-tf.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.asia-static-bucket-tf.id
  policy = data.aws_iam_policy_document.public_read.json

  depends_on = [aws_s3_bucket_public_access_block.public_access]
}



