#!/usr/bin/env bash
if [[ $(git config --get remote.origin.url) == *"github"* ]]; then
  echo "remote origin is on github.com"
else
  GIT_USER=$(git config --get remote.origin.url | awk -F/ '{ print $3 }' | awk -F@ ' { print $1 }')
  GIT_HOST=$(git config --get remote.origin.url | awk -F/ '{ print $3 }' | awk -F@ ' { print $2 }' | awk -F: '{ print $1 }')
  GIT_PORT=$(git config --get remote.origin.url | awk -F/ '{ print $3 }' | awk -F: '{ print $2 }')
  GIT_PREPATH=$(git config --get remote.origin.url | awk -F: '{ print $3 }')
  GIT_PATH=${GIT_PREPATH:${#GIT_PORT}:$((${#GIT_PREPATH}-1))}

  ssh -p ${GIT_PORT} ${GIT_USER}@${GIT_HOST} "cd ${GIT_PATH}; echo && echo \"${GIT_USER}@${GIT_HOST}:${GIT_PORT}${GIT_PATH}$ git push\"; git push;"
fi