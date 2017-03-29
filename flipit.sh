#!/bin/sh

# Process our arguments.
# -r GIT_REPOSITORY
# -g REPOSITORY_PUBLIC_DIRECTORY_PATH
# -s SERVER_PUBLIC_DIRECTORY_PATH
# -c CONNECT_TO
while getopts r:g:s:c: option
do
    case "${option}"
    in
        # Create our repository variable.
        r) GIT_REPOSITORY=${OPTARG};;

        # Create my repository 'public' directory variable.
        g) REPOSITORY_PUBLIC_DIRECTORY_PATH=${OPTARG};;

        # Create my servers 'public' directory variable.
        s) SERVER_PUBLIC_DIRECTORY_PATH=./${OPTARG};;

        # SSH connection details
        c) CONNECT_TO=${OPTARG};;
    esac
done

# Create a variable to store the unix time.
# As 'date +%s' itself is a command, we need to tell the system to interpret it
#   as a command and not simply a string. To do this we can wrap the command in
#   parenthesis and prepend it with the '$' sign, e.g. $(COMMAND_HERE).
UNIX_TIME=$(date +%s)

# Create a variable and store the path to this new deployment, we'll need it
#   later.
DEPLOYMENT_DIRECTORY=./flipit/deploys/$UNIX_TIME

# Create our server script variable.
# You'll notice the script is wrapped in double quotes (").
# Make sure to escape any double quotes (\") in the script.
SERVER_SCRIPT="

# Make the directory. To learn more type 'man mkdir'.
# The -p flag tells the system to also create any intermediate directories.
# To utilise our 'DEPLOYMENT_DIRECTORY' variable we append the '$' sign.
mkdir -p $DEPLOYMENT_DIRECTORY

# Clone our respository and pass the deployment directory as the destination
#   in which to store the repository.
git clone $GIT_REPOSITORY $DEPLOYMENT_DIRECTORY

# Make a link...oh I mean FlipIt™
# The -s flag tells the system to make a [symbolic link](https://en.wikipedia.org/wiki/Symbolic_link). This is important
#   and also very handy for a lot of things. If you've ever used [Laravel Valet](https://laravel.com/docs/5.4/valet)
#   before, you've been creating symbolic links! Well worth investigating.
# The -h flag tells the system not to follow any symbolic links. This was doing
#   my head in I ended up with ./public_html/public_html links! Inception!
# the -f flag tells the system that if a link already exists, remove it and add
#   this link instead.
ln -s -n -f $DEPLOYMENT_DIRECTORY/$REPOSITORY_PUBLIC_DIRECTORY_PATH $SERVER_PUBLIC_DIRECTORY_PATH"

# SSH into the server
# The -t flag will mean that the scripts output will be returned to our console
#   so we can see if it was successful, otherwise we don't get the console output.
# The server script provided will be executed
ssh $CONNECT_TO -t $SERVER_SCRIPT