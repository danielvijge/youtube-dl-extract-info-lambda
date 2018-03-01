# Webservice to extract info from media websites using youtube-dl

## Pre-requisites
* Install the AWS command line interface tools from https://aws.amazon.com/cli/ If you have an OS with a package manager, you can also install it from there. For example, on MacOS you can use brew to install it.
* Configure aws-cli by running 'aws configure'
* Have an IAM role with Lambda and CloudWatch Logs permissions (AWSLambdaBasicExecutionRole)

## Configuration
* Open the file deploy.sh
* Configure the function name you want to use (default *youtube-dl-extract-info*)
* Configure the role to use. This role must have Lambda and CloudWatch Logs permissions

## Deployment
* Run *./deploy.sh* to deploy the function to Lambda
* First the script will update youtube-dl to the latest version
* Next it will deploy to Lambda. If the function does not exist, it will create it, else it will update the existing function

## Connecting an API Gateway to the function
* Go to AWS API Gateway
* Create a new API called *youtube-dl*
* Click on the newly create API
* Add a new resource *youtube-dl*
* Click on the new resource
* Add a new resource *extract-info*
* Click on the new resource
* Add a new method. From the list select GET and click the checkbox
* Select *Lambda function*
* Check *Use Lambda Proxy integration*
* Select the region where the Lambda function is deployed
* Type the name of the Lambda function (default *youtube-dl-extract-info*)
* Click Save
* Optionally, add CORS to the resource by clicking on *extract-info* and clicking *Enable CORS* from the Actions menu
* From the Actions menu, click *Deploy API*
* Choose *New stage*
* Type a stage name, like *prod*. Click Deploy

Your API is now deployed. The stage screen will display the API address. You can invoke your API with:

https://{address}.{region}.amazonaws.com/prod/youtube-dl/extract-info?url=https://www.youtube.com/watch?v=dQw4w9WgXcQ

Optionally, you can also create a Custom Domain Name and give a nice URL to this API function