provider "aws" {
  region = "ap-south-1"
  profile = "AdminAccess-644608486460"
 
}
 
resource "aws_s3_bucket" "minfy_bucket" {
  bucket = "minfy-training-sivanithin-s3-3346"
}