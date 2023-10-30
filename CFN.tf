resource "aws_cloudformation_stack" "network" {
  name         = "EC2-Scheduler-stack"
  template_url = "https://s3.amazonaws.com/solutions-reference/instance-scheduler-on-aws/latest/instance-scheduler-on-aws.template"
  capabilities = ["CAPABILITY_IAM"]

  parameters = {
    MemorySize                  = "128"
    SchedulerFrequency          = "5"
    DefaultTimezone             = "Europe/London"
    ScheduleLambdaAccount       = "Yes"
    SchedulingActive            = "Yes"
    CreateRdsSnapshot           = "No"
    ScheduleRdsClusters         = "No"
    ScheduledServices           = "EC2"
    TagName                     = "Schedule" # tag key to apply to EC2 instances, tag value should be the CFN schedule name
    Namespace                   = "Dev"
    Regions                     = "eu-west-1, us-east-1"
    UseCloudWatchMetrics        = "No"
    Trace                       = "No"
    EnableSSMMaintenanceWindows = "No"
    LogRetentionDays = "7"
    StartedTags = "InstanceScheduler-LastAction=Started By {scheduler} {year}/{month}/{day} {hour}:{minute}{timezone},"
    StoppedTags = "InstanceScheduler-LastAction=Stopped By {scheduler} {year}/{month}/{day} {hour}:{minute}{timezone},"
    
    UsingAWSOrganizations       = "No" # If using AWS org, comment this line and 
                                       # uncomment lines 28-29, specify the account ids as principals, run the remote template in the spoke accounts
                                       # see AWS instance scheduler docs for more info
    # UsingAWSOrganizations = "Yes"
    # Principals = ""
  }

}

resource "aws_cloudformation_stack" "schedule" {
  name         = "customschedule"
  template_body = "${file("${path.module}/CFN_Templates/schedule.yml")}"
  capabilities = ["CAPABILITY_IAM"]

  parameters = {
    ServiceInstanceScheduleServiceTokenARN = aws_cloudformation_stack.network.outputs.ServiceInstanceScheduleServiceToken
  }

  depends_on = [ aws_cloudformation_stack.network ]

}