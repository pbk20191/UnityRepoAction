#!/bin/bash
set -e
set -o pipefail
git-lfs install

git submodule update --init --recursive
cd target
git submodule update --remote project
git add project
if git diff --staged --quiet; then
    echo "No changes to commit in project."
else
    git commit -m "Update project to latest commit"
    git push
fi
cd ..
git add target
if git diff --staged --quiet; then
    echo "No changes to commit in target."
else
    git commit -m "Update target to latest commit"
    git push origin:main
fi