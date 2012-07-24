#!/bin/bash

##################
#Script doing screenshot for chosen area
##################
# Script user programs:
# 1. scrot - is a simple command line screen capture.
# 2. gxmessage - create a pop-up
# 3. curl - upload image on the server (http, https or ftp).
# 4. xsel - is a command-line program for getting and setting the contents of the X selection, i.e. inser text into buffer.

# API Key provided by Alan@imgur.com
#apikey="b3625162d3418ac51a9ee805b1840452"
apikey="bbf3bf200c0017f3e9df69750a131db6"

# Create a directory for screenshots.
DIR=~/Pictures/screenshots/

#Create a file name
file=$DIR"IMG-"`date '+%Y%m%d-%s'`.jpg;

#Create a screenshot with (choosing an area) 
scrot -q 95 -s -b "$file";

#Create a pop-up with question
gxmessage -title "Image Created Successfully" -center -buttons "In the Internet:1, For Computer:2, Remove:3" "What are we do ?";
exitcode=$?;

#Handler buttons
case "$exitcode" in
    #1 - Upload image on the server
    1)
    # upload the image
    response=$(curl -F "key=$apikey" -H "Expect: " -F "image=@$file" \
	    http://imgur.com/api/upload.xml 2>/dev/null)
echo $response
    # parse the response and output our stuff
    url=$(echo $response | sed -r 's/.*<original_image>(.*)<\/original_image>.*/\1/')

    echo $url
    #LINK=${LINK:0:-4}

    #We can remove local copy ( I don't want ,) )
    # rm "$file";

    #Inser link into buffer
    echo "$url" | xsel -b -i;

    #Show pop-up, that all is well :)
    #kdialog --passivepopup 'Link is inserted into the buffer' 5 
    gxmessage -title "Done!" -center "Link '$url' is inserted into the buffer";;
    
    #2 - For Computer
    2);;

    #3 - Remove screenshot 
    3) rm "$file";;
esac
