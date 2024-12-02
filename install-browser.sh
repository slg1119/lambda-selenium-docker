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
dnf install -y google-chrome-stable