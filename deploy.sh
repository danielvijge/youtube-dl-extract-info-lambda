#!/bin/sh

FUNCTIONNAME=youtube-dl-extract-info
ROLE=arn:aws:iam::852498999003:role/service-role/lambda-runner

if [ !  -L "youtube_dl" ]; then
    if [ ! -d "youtube-dl" ]; then
        echo "Cloning youtube-dl..."
        git submodule add https://github.com/rg3/youtube-dl.git
    fi
    ln -s youtube-dl/youtube_dl youtube_dl
fi

echo "Getting latest source for youtube-dl from Github..."
cd youtube-dl
git pull
cd ..

echo "Building AWS Lambda package..."
rm -f youtube-dl-extract-info.zip
zip -q -r youtube-dl-extract-info.zip extract_info.py youtube_dl/* -x \*.git\* \*.pyc\* 2>&1

if type aws &> /dev/null ; then
    if aws lambda list-functions --output text --no-paginate --query 'Functions[*].FunctionName' | grep -q $FUNCTIONNAME ; then
        echo "Deploying to AWS..."
        aws lambda update-function-code --function-name $FUNCTIONNAME --zip-file fileb://youtube-dl-extract-info.zip 2>&1
    else
        if [ ! -z "$ROLE" ]; then
            echo "Deploying to AWS for the first time..."
            aws lambda create-function --function-name $FUNCTIONNAME --runtime 'python2.7' --role $ROLE --handler 'extract_info.lambda_handler' --timeout 10 --zip-file fileb://youtube-dl-extract-info.zip 2>&1
        else
            echo "[WARNING] Cannot create Lambda function. No role was specified. Create a new role with Lambda and CloudWatch Log permissions"
        fi
    fi
else
    echo "[WARNING] aws-cli is not installed. Install aws-cli or deploy the package manually"
fi