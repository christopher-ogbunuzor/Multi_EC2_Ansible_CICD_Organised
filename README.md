# Multi_EC2_Ansible_CICD_Organised

## SSM & EC2
The S3 gateway endpoint was created for `eu-west-1` region. So, when you access the Private EC2 server using SSM,you can run the command below to list all S3 buckets. If you do not add the `--region eu-west-1`, the commands times out and fails

```
aws s3 ls --region eu-west-1
```