#!/usr/bin/env bash
# exit on error
set -o errexit

# 1. Install Chrome (because Render Ruby env doesn't have it)
echo "Installing Chrome..."
STORAGE_DIR=/opt/render/project/src/chrome
mkdir -p $STORAGE_DIR
cd $STORAGE_DIR
wget -P ./ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -x ./google-chrome-stable_current_amd64.deb $STORAGE_DIR
rm ./google-chrome-stable_current_amd64.deb
cd /opt/render/project/src # Go back to main folder

# 2. Run your normal build commands
echo "Running Build..."
npm install
bundle install
bundle exec hanami assets compile
(bundle exec hanami db migrate || true)
