#!/bin/bash
echo updating brew
brew update
echo installing node/npm
brew install node npm

npm install -g offline-docs express
