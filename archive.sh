#!/bin/bash
#Fill these in with the paths to the actual synced directories
ARCHIVE=/slow/sync/archive
VM=/fast/sync/OVA
ISO=/fast/sync/iso
PERSONAL=/fast/sync/personal
SCHOOL=/fast/sync/school
WORSHIP=/slow/sync/ballston-archive
CAMERA=/fast/sync/camera

#Copy the camera sync into the personal sync
rsync --checksum --recursive --exclude=".stfolder" --exclude=".sync" $CAMERA $PERSONAL/photos

#Create Array of dirs for cleaning
UNCLEAN=($VM $ISO $PERSONAL $SCHOOL $CAMERA)
#Remove the conflict files and remove them
#for DIR in ${UNCLEAN}; do
#	find $DIR -name *.sync-conflict* -delete
#done

#Create Array of dirs for syncing
SOURCES=($VM $ISO $PERSONAL $SCHOOL $WORSHIP)
for DIR in ${SOURCES[*]}; do
	NAME=$(echo $DIR |rev | cut -d"/" -f1 | rev)
	rsync --checksum --recursive --exclude=".stfolder" --exclude=".sync" --backup --suffix=$(date +%d%m%Y) $DIR $ARCHIVE/$NAME
done
