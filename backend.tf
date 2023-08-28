terraform {
  backend "s3" {
    bucket         = "chris16555tfstate"
    # bucket         = "my-first-lambdabucket-194694014750"
    key            = "MultiEc2AnsibleCICD_Organised/terraform.tfstate"
    dynamodb_table = "terraform-lock"
  }
}