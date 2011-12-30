#!/bin/bash
if [ -z "$1" ]; then
  echo "private key not specified"; exit
fi
if [ ! -e "$1" ]; then
  echo "private key missing";exit
fi
APP="build/Release/PBNotify.app"
VER=`grep 'CFBundleVersion' -A 1 pbgrowl/PBNotify-Info.plist|tail -n 1|ruby -e '(STDIN.read =~ /([\d\.]+)/);print $1'` 
echo "new version is ${VER}. enter or C-c"
read
xcodebuild
ZIPPED="PBNotify-v${VER}.zip"
mv build/Release/PBNotify.app .
zip -r $ZIPPED PBNotify.app
rm -rf ./PBNotify.app
echo -e "\nsuccess. created ./${ZIPPED}"
echo "REMEMBER: chechout gh-pages"
echo "REMEMBER: edit index.html"
echo "REMEMBER: edit changes/$VER.html"
echo "REMEMBER: edit appcast.xml"
ls -al $ZIPPED|awk '{print $5}'
ruby ./for_sparkle/sign_update.rb $ZIPPED "$1"
