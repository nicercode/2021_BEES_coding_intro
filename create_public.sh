#!/bin/bash

rm -rf public
mkdir public
cp -r lessons public
cp -r cheatsheets public
cp -r slides public
cp *.md public
find public -name "TODO*" -delete
find public -name "*answers*" -delete
find public -name "*.Rproj.user*" -delete
find public -name "*DS_*" -delete
find public -name "*.key*" -delete
