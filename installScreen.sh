#!/bin/bash

if [ ! -d ~/Pictures ] 
then
    mkdir ~/Pictures
fi

if [ ! -d ~/Pictures/screenshots ] 
then
    mkdir ~/Pictures/screenshots
fi

sudo aptitude install scrot gxmessage xsel
