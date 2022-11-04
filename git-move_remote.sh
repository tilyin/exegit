#!/bin/bash
# ls -lah | awk '{ if ( $1 ~ /^d/ ) print }' | awk '{ if ( $9 !~ /^\.|dns/ ){ print $9; }}'

WORK_ITEM=$1
GIT_ITEM=$WORK_ITEM.git

git clone --bare $WORK_ITEM $GIT_ITEM
scp -r -i /home/tim/.ssh/id_ed25519 -P 4961 $GIT_ITEM git@10.1.1.254:/home/git/data/$GIT_ITEM
ssh -p 4961 -i /home/tim/.ssh/id_ed25519 git@10.1.1.254 "cd /home/git/data/$GIT_ITEM; git init --bare --share"
rm -r $GIT_ITEM
