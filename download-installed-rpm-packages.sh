#!/bin/bash
#Simple loop to download installed rpm packages from your OS in custom directory which you will specify after interactive question from this script

read -p 'Enter a full path where you want to save a list of installed rpm packages from your OS (exaple: "/tmp/path/to/your/dir/"): ' pathToList
read -p 'Enter a full path of a directory in which you want to download a packages (exaple: "/tmp/path/to/your/dir/": ' downloadDirectory
rpm -qa >> "$pathToList"
for packages in $(cat $pathToList)
do
 yumdownloader --destdir=$downloadDirectory --resolve "$packages"
done
