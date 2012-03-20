#!/bin/bash

rm -rf npm-shrinkwrap.json package.json
cp package.json.1 package.json
echo Installing request 0.2.100
npm install

rm -rf npm-shrinkwrap.json package.json
echo Updating request to 0.2.153
cp package.json.2 package.json
echo Copying outdated node_modules
cp -rp node_modules node_modules.bak
echo Installing request 0.2.153
npm install

echo Generating shrinkwrap w/ version 0.2.153
npm shrinkwrap

echo Moving outdated node_modules back
rm -rf node_modules
mv node_modules.bak node_modules
NPM_VER=$(npm ls | grep request | cut -d '@' -f2)
echo $NPM_VER

echo Installing from shrinkwrap
npm install

echo Testing installed version of request
NPM_VER=$(npm ls | grep request | cut -d '@' -f2)
echo $NPM_VER
test "$NPM_VER" = "0.2.153"
