#!/bin/bash

release=public/2021_bees_data_intro

rm -rf $release
mkdir public
mkdir $release

cp -r lessons $release
cp -r cheatsheets $release
cp -r slides $release
cp *.md $release
find $release -name "TODO*" -delete
find $release -name "*answers*" -delete
find $release -name "*.Rproj.user*" -delete
find $release -name "*DS_*" -delete
find $release -name "*.key*" -delete
