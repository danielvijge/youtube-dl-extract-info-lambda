# Webservice to extract info from media websites using youtube-dl

## Pre-requisites
* Install the serverless framework. If you have an OS with a package manager, you can also install it from there. For example, on MacOS you can use brew to install it.
* Make sure the AWS credentials are set correctly. Refer the serverless documentation on how to do this.

## Deployment
* Run *./deploy.sh* to deploy the function to AWS

## Configuration
* You can add options to the deploy script to configure the name and region. Supported variables are *service*, *region*, *state*, and *version*. Any serverless command line option can also be passed.

Your API is now deployed. The stage screen will display the API address. You can invoke your API with:

https://{address}.{region}.amazonaws.com/dev/extract-info?url=https://www.youtube.com/watch?v=dQw4w9WgXcQ

Optionally, you can also create a Custom Domain Name and give a nice URL to this API function