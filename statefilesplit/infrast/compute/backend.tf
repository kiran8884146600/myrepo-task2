terraform {
  backend "s3" {
    bucket = "my-demo-terraform98765"
    key    = "terraform/split/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    kms_key_id = "arn:aws:kms:ap-south-1:686255943556:alias/aws/s3"
    dynamodb_table = "my-dynamodb-table"
  }
}
