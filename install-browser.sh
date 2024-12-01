#!/bin/bash

echo "Downloading Chromium..."
CHROMIUM_ROOT="http://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64"
CHROMIUM_LATEST=`wget -q -O - "$CHROMIUM_ROOT/LAST_CHANGE"`
wget $CHROMIUM_ROOT/$CHROMIUM_LATEST/chrome-linux.zip -P /tmp/
unzip /tmp/chrome-linux.zip -d /tmp/
mv /tmp/chrome-linux/ /opt/chrome

wget $CHROMIUM_ROOT/$CHROMIUM_LATEST/chromedriver_linux64.zip -P /tmp/
unzip /tmp/chromedriver_linux64.zip -d /tmp/
mv /tmp/chromedriver_linux64/chromedriver /opt/chromedriver