#!/bin/sh

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
    echo "Deploying to AWS..."
    aws lambda update-function-code --function-name youtube-dl-extract-info --zip-file fileb://youtube-dl-extract-info.zip 2>&1
else
    echo "[INFO] aws-cli is not installed. You must deploy the package manually"
fi