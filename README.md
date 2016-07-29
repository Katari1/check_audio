# check_audio.sh


This was created for some troubleshooting I had to do at work.  We had an issue where we were only capturing one side of a recorded call.  However we didn't have a way to identify how frequetly this was ocurring.  I devised a way where we go through the raw recording of files and based on the naming structure of the audio files tell me how many calls only had one side of audio.When I first saw this I wrote a really horrible bash one liner to do it that took hours to parse through 70k files.  It is horrible.  Here is that one liner for reference

for i in `ls | awk -F_ '{print $1}' | awk '!a[$0]++'`;do if [[ `ls | grep $i | grep FAR.*\NEAR | wc -l` -ne `ls | grep $i | grep NEAR.*\FAR | wc -l` ]];then echo "$i has unequal NEAR_FAR";elif [[ `ls | grep $i | grep FAR.*\FAR | wc -l` -ge 1 ]];then echo "$i has FAR FAR";elif [[ `ls | grep $i | grep NEAR.*\NEAR` -ge 1 ]];then echo "$i is NEAR NEAR";fi;done >> /tmp/output_files.txt


V1 goes through a list and compares the file but is inefficient as it goes through all the files for each unique identifier.
V2 takes the files and puts it in a dictionary and then only searches the files with the set unique identifier.  Much faster.
