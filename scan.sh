#!/bin/bash

# Script for scanning images with `scanimage` and converting result to pdf

# 1 - name
# 2 - number
# 3 - mode

if [ -z ${1} ] && [ -z ${2} ] &&  [ -z ${3} ]
then
    echo -e "Usage:\nscan.sh <Name> <Number_of_pages(1..99)> <Mode:Gray|Color>"

else
    if [ -z ${1} ] || [ -z ${2} ] ||  [ -z ${3} ]
    then echo "I can't get some parameters from you..."
         echo "Try to run ./epscan without parameters to learn more."
    else
	num=`echo ${2}|grep ""| sed 's/[a-z]//g'`
        # I scan from 1 to 99 pages
        if [ "${num}" -gt "0" ] && [ "${num}" -le "99" ]
        then
	    if (test ${3} = "Color") || (test ${3} = "Gray")
	    then echo "Scanning: Name="${1}", Number="${num}", Mode="${3}
		mkdir -p ~/scanned/${1}
		cd ~/scanned/${1}
		scanimage --format=pnm --resolution 300 --batch-count=${2} --batch-prompt --mode ${3} -p -x 210
		convert out*.pnm -quality 40 ${1}.jpg
		rm -rf out*.pnm

		echo "Convert scanned pics to PDF? y/n"
		read x
		while [ "${x}" != "y" ] && [ "${x}" != "n" ]
		do
		    echo "Convert scanned pics to PDF? y/n"
		    read x
		done
		if [ ${x} = "y" ]
		then convert ${1}*.jpg ${1}.pdf
		    else exit
		fi
	    else echo "<Mode> is neither <Gray> nor <Color>"
		 echo "Try to run ./epscan without parameters to learn more."
	    fi
        else echo "Something wrong with <Number_of_pages>..."
	    echo "Try to run ./epscan without parameters to learn more."
        fi
    fi
fi
exit 0
