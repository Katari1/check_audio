# check_audio.sh


This was created for some troubleshooting I had to where we didn't have any tools.  We had an issue where we were only capturing one side of a recorded call.  The big problem was we didn't have a way to identify how frequetly this was ocurring.  I devised a way where we go through the raw recording files and based on the naming structure of the audio files tell me how many calls only had one side of audio.  The naming sequence of the expected files is as follows:
1232a741__20160729T154402Z__04c8b7f5__FAR__10.9.2.5.19986__NEAR__10.8.43.14.24582--bf7116da0012a7499.wav.gz
The first part of the file name is the unique identifier.  This represents the unique identifier of the call.  Then if we continue through the file name we see "FAR..NEAR".  If a call is recorded correctly we should have an equal number of files "FAR..NEAR" and "NEAR..FAR".  As a result I wrote a script to go in and tell me if there were instances of a call that only had "NEAR..FAR" or "FAR..NEAR". 

When I first started troubleshooting this issue I wrote a really horrible bash one liner to do it that took hours to parse through 70k files.  It was  horrible.  It was completely inefficient and the logic was poor but it got the job done albeit it took a while.  Here is that one liner for reference

for i in `ls | awk -F_ '{print $1}' | awk '!a[$0]++'`;do if [[ `ls | grep $i | grep FAR.*\NEAR | wc -l` -ne `ls | grep $i | grep NEAR.*\FAR | wc -l` ]];then echo "$i has unequal NEAR_FAR";elif [[ `ls | grep $i | grep FAR.*\FAR | wc -l` -ge 1 ]];then echo "$i has FAR FAR";elif [[ `ls | grep $i | grep NEAR.*\NEAR` -ge 1 ]];then echo "$i is NEAR NEAR";fi;done >> /tmp/output_files.txt

I then decided to write it in Python and now it takes about 1 second to run through 100k files.

V1 goes through a list and compares the file but is inefficient as it goes through all the files for each unique identifier.  Lots of output as it tells you about every call.
V2 takes the files and puts it in a dictionary and then only searches the files with the set unique identifier.  Much faster.  Also the output is straight forward and tells you how many of only one way audio there is.  Takes an argument for the audio files path.

This script needs to run on a bunch of servers so to do that I wrote check_calls.sh to run it.  It uses the /etc/hosts to get the servers it needs to run on and the script is stored locally on each server.  It then connects via ssh to each server and executes the script with the provided path.  It takes about 10 seconds to run on 6 servers.
