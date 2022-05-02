#!/bin/bash

#______________NOAA 15________________

#variable statement
noradID=28654
datapath=/home/pi/r2cloud/data/satellites/$noradID/data/
TZ=+02:00

while true
do
workdate="$(date +"%d-%m-%Y")"
workyear="$(date +"%Y")"
workmonth="$(date +"%m")"
workday="$(date +"%d")"
workhour="$(date +"%H")"
workminute="$(date +"%M")"
worksecond="$(date +"%S")"


#condition statements


    if [ ! -e "/var/www/html/data/noaa/noaa15/donemarks/"$workdate"_done.mark" ]; then


            cd $datapath
            cd  "$(\ls -1dt ./*/ | head -n 1)"

            if [ ! -e "a.jpg" ]; then

                echo "no valid data"
                touch "/var/www/html/data/noaa/noaa15/donemarks/"$workdate"_done.mark"


            else

                #folders build
                mkdir /var/www/html/data/noaa/noaa15/"$workdate"
                mkdir /var/www/html/data/noaa/noaa15/"$workdate"/decoded

                #audio copy
                cp ./output.wav /var/www/html/data/noaa/noaa15/"$workdate"/noaa15_"$workdate"_raw.wav
                cd /var/www/html/data/noaa/noaa15/"$workdate"


                #audio decoding
                noaa-apt noaa15_"$workdate"_raw.wav -s noaa_15 -t "$workyear"-"$workmonth"-"$workday"T"$workhour":"$workminute":"$worksecond"$TZ -o ./decoded/noaa15_"$workdate"_default.png
                noaa-apt noaa15_"$workdate"_raw.wav -s noaa_15 -t "$workyear"-"$workmonth"-"$workday"T"$workhour":"$workminute":"$worksecond"$TZ -F -c telemetry -o ./decoded/noaa15_"$workdate"_fcolort.png
                noaa-apt noaa15_"$workdate"_raw.wav -s noaa_15 -t "$workyear"-"$workmonth"-"$workday"T"$workhour":"$workminute":"$worksecond"$TZ -F -c histogram -o ./decoded/noaa15_"$workdate"_fcolorhg.png 
                noaa-apt noaa15_"$workdate"_raw.wav -s noaa_15 -t "$workyear"-"$workmonth"-"$workday"T"$workhour":"$workminute":"$worksecond"$TZ -F -c disable -o ./decoded/noaa15_"$workdate"_fcolor0c.png 
                touch "/var/www/html/data/noaa/noaa15/donemarks/"$workdate"_done.mark"

            fi

    else

            echo "job already done"
            sleep 1200
    fi

done
