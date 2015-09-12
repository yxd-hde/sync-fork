#!/bin/bash

set -x
set -v

FORK_REMOTE_NAME="fork"
REPOS="${WERCKER_CACHE_DIR}/repos"

RECIPE=${1}
source ${RECIPE}

RECIPE_NAME=$(echo ${RECIPE} | sed -r -n -e 's/recipe\/(.*)\.recipe/\1/p')

REPO=${REPOS}/${RECIPE_NAME}

# Clone if repository does not exists.
if [ ! -d ${REPO} ]; then
    git clone ${SOURCE} ${REPO}
fi

# Update local repository to sync with origin
cd ${REPO}
git checkout ${SOURCE_BRANCH} || \
    git checkout -b ${SOURCE_BRANCH} --track origin/${SOURCE_BRANCH}
git remote update
git pull -v --ff-only

# Setup credentials
git config --global credential.helper store
echo "https://${FORK_USER}:${FORK_PASSWIRD}@github.com" > \
     ${HOME}/.git-credentials

# Push to fork repository
FORK_REMOTE=$(git remote | grep ${FORK_REMOTE_NAME})
if [ -n ${FORK_REMOTE} ]; then
    git remote add ${FORK_REMOTE_NAME} ${FORK}
fi

git push ${FORK_REMOTE_NAME} ${SOURCE_BRANCH}:${FORK_BRANCH}
