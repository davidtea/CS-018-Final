#!/bin/bash
# I don't think awk can use wget within a .awk so I made a simple bash script to download first then run the awk script
if [ -f 132.txt ]
then
  echo "132.txt already exists, will not download again."
else
  wget www.gutenberg.org/files/132/132.txt
fi
awk -f parse.awk 132.txt
