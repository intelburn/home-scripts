#!/bin/bash
#Fill these in with the paths to the actual synced directories
ARCHIVE=
VM=
ISO=
PERSONAL=
SCHOOL=
WORSHIP=
CAMERA=

#Copy the camera sync into the personal sync
rsync --checksum --recursive --exclude=.stfolder $CAMERA $PERSONAL/photos

#Create Array of dirs for cleaning
UNCLEAN=($VM $ISO $PERSONAL $SCHOOL $CAMERA)
#Remove the conflict files and remove them
for DIR in ${UNCLEAN}; do
	find $DIR -name *.sync-conflict* -delete
done

#Create Array of dirs for syncing
SOURCES=($VM $ISO $PERSONAL $SCHOOL $WORSHIP)
