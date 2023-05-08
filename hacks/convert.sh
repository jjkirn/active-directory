#!/bin/bash

# This ccript converts a users.txt file with three cols of users names to a new version of users.txt with all names in one col
# This is useful for converting the output of PS C:> net user /domain to a formated users.txt for CME
# It requires a file with a single col of users to remove (remove.txt) - Administrator, Guest, krbtgt 
# JJK 5.8.2023
#
# Put all users into individual col files
sed -e 's/  \+/\t/g' users.txt | cut -f1 > col1.txt
sed -e 's/  \+/\t/g' users.txt | cut -f2 > col2.txt
sed -e 's/  \+/\t/g' users.txt | cut -f3 > col3.txt
# Combine all the individual col files to combined.txt, remove temp files
cat col1.txt col2.txt col3.txt > combined.txt
sort -u combined.txt > new.txt
rm col1.txt col2.txt col3.txt combined.txt
# Use a list of users to remove (remove.txt) create a clean list
sed -e "$(sed 's:.*:s/&//ig:' remove.txt)" new.txt > clean.txt
# Get rid of any blank lines
grep . clean.txt > new.txt
# Remove more temp files
rm users.txt clean.txt
# Put final results back into original users.txt
mv new.txt users.txt

