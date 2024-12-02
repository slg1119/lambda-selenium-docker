#!/bin/bash

echo "Install Chrome"

tee /etc/yum.repos.d/google-chrome.repo << EOL
[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOL
rpm --import https://dl.google.com/linux/linux_signing_key.pub
dnf install -y google-chrome

CHROME_ROOT="http://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64"
CHROME_LATEST=`wget -q -O - "$CHROME_ROOT/LAST_CHANGE"`

wget $CHROME_ROOT/$CHROME_LATEST/chromedriver_linux64.zip -P /tmp/
unzip /tmp/chromedriver_linux64.zip -d /tmp/
mv /tmp/chromedriver_linux64/chromedriver /opt/chromedriver