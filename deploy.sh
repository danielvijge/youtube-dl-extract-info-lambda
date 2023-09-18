#!/bin/sh

if [ ! -L "youtube_dl" ]; then
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

serverless deploy $@