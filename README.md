# circleci-windows-ami
Windows AMI creation deploy using CircleCI, Packer, Ansible and Terraform

To run this pipeline, there are some resources that will need to be in place before launching

1. A VPC must be launched to retrieve the `vpc-id` and `subnet-id` for creation of the AMI
2. The `vpc-id` and `subnet-id` need to be input in the `tf.vars` file
3. A bucket must be created ahead of time to hold the terraform state file
4. The bucket information must be input into the `backend.tf` file
5. Terraform needs to be initialized beofre running the code through the pipeline

### Launching the bucket for Terraform state

This is a first time manual step, but is necessary to store the Terraform state. Create the S3 bucket where you plan to store the state and record the name given.

### Launching the VPC

Navigate into the `vpc` folder and run the following code to initiate the code for the vpc.

`terraform init`

You will be asked for the 
```
    - profile name
    - bucket name
    - file name
```

Use the respected values in the variables asked.

Once that is done, you can go ahead and run `terraform apply`

