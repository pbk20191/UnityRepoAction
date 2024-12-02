#!/bin/bash
set -e
set -o pipefail
git-lfs install

git submodule update --init --recursive
cd target/project
git pull origin develop
cd ..
git add project
if git diff --staged --quiet; then
    echo "No changes to commit in project."
else
    git commit -m "Update project to latest commit"
fi
git push
cd ..
git add target
if git diff --staged --quiet; then
    echo "No changes to commit in target."
else
    git commit -m "Update target to latest commit"
fi
git push