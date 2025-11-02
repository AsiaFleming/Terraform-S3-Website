#create s3 bucket 
resource "aws_s3_bucket" "asia-static-bucket-tf" {
  bucket = var.bucketname
}

#Disable ACLs and enforce bucket ownership
resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.asia-static-bucket-tf.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
#Configure public access settings
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.asia-static-bucket-tf.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
#Set the bucket ACL to public-read
resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [ 
    aws_s3_bucket_ownership_controls.bucket_ownership,
    aws_s3_bucket_public_access_block.public_access,
   ]
  bucket = aws_s3_bucket.asia-static-bucket-tf.id
  acl    = "public-read"
}
#Upload index.html and error.html files to the bucket
resource "aws_s3_object" "index" {
    bucket = aws_s3_bucket.asia-static-bucket-tf.id
    key    = "index.html"
    source = "index.html"
    content_type = "text/html"
    acl          = "public-read"
}

resource "aws_s3_object" "error" {
    bucket = aws_s3_bucket.asia-static-bucket-tf.id
    key    = "error.html"
    source = "error.html"
    content_type = "text/html"
    acl          = "public-read"
  
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
  depends_on = [ aws_s3_bucket_acl.bucket_acl ]
}


