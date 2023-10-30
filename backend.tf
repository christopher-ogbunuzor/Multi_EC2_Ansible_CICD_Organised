terraform {
  backend "s3" {
    bucket         = "chris16555tfstate0387"
    key            = "MultiEc2AnsibleCICD_Organised/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region         = "eu-west-1"
  }
}