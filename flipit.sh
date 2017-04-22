#!/bin/sh

while getopts r:g:s:c: option
do
    case "${option}"
    in
        r) GIT_REPOSITORY=${OPTARG};;
        g) REPOSITORY_PUBLIC_DIRECTORY_PATH=${OPTARG};;
        s) SERVER_PUBLIC_DIRECTORY_PATH=./${OPTARG};;
        c) CONNECT_TO=${OPTARG};;
    esac
done

UNIX_TIME=$(date +%s)

DEPLOYMENT_DIRECTORY=./flipit/deploys/$UNIX_TIME

ssh -tt $CONNECT_TO <<REMOTE_SCRIPT

mkdir -p $DEPLOYMENT_DIRECTORY

git clone --depth 1 $GIT_REPOSITORY $DEPLOYMENT_DIRECTORY

ln -s -n -f $DEPLOYMENT_DIRECTORY/$REPOSITORY_PUBLIC_DIRECTORY_PATH $SERVER_PUBLIC_DIRECTORY_PATH

exit

REMOTE_SCRIPT