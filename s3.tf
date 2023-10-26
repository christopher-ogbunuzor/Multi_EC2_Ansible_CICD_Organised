resource "aws_s3_bucket" "example" {
  bucket = "bucket147896577"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}