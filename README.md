# Running R (language) Based APIs in AWS

This is a sample repo to demonstrate how to run APIs, written in R, in an AWS environment. It the CloudFormation template creates an ECS cluster with a defined number of tasks fronted by a NLB, and exposed by API Gateway.

#### *// TODO: Add CI/CD pipeline.*

## Background

R functions can be converted into RESTful APIs using the plumber package. Plumber uses annotations to define and configure the endpoints. Once annotated, the API can be run locally or in a server environment using the RStudio Connect platform. RStudio Connect is single threaded and multiple instances must be licensed to handle even moderate traffic.

One option to host a plumber based API is via Docker. RStudio publishes a plumber parent image to use as your starting point. Once you have created a Docker image of your API, you can deploy to an ECS cluster, front with a NLB, and expose via API Gateway.

## Docker build and push to ECR

```sh
aws ecr get-login-password --region {YOUR_Region} | docker login --username AWS \
--password-stdin {YOUR_AccountId}.dkr.ecr.{YOUR_Region}.amazonaws.com

docker build -t {YOUR_AccountId}.dkr.ecr.{YOUR_Region}.amazonaws.com:latest .

docker push {YOUR_AccountId}.dkr.ecr.{YOUR_Region}.amazonaws.com:latest
```

## Build AWS environment via CloudFormation

Required parameters:
* ECRRepositoryUri - The URI of your ECR repository used above.
* ECRImageTag - The tag for the image to use. In the example above, it is 'latest'.
* TaskCount - How many ECS tasks to start.
* StageName - Name the API Gateway stage.

```sh
aws s3 mb s3://{YOUR_BucketName}

aws cloudformation package \
--template-file template.yaml \
--s3-bucket {YOUR_BucketName} \
--output-template-file {YOUR_OutputTemplateFile}

aws cloudformation deploy \
--stack-name {YOUR_StackName} \
--template-file {YOUR_OutputTemplateFile} \
--parameter-overrides \
"ECRRepositoryUri={YOUR_ECRRepositoryUri}" \
"ECRImageTag={YOUR_ECRImageTag}" \
"TaskCount={YOUR_TaskCount}" \
"StageName={YOUR_StageName}" \
--s3-bucket {YOUR_BucketName} \
--capabilities CAPABILITY_IAM
```

## Architecture CloudFormation builds
<img src="./docs/architecture.png" width="600">
