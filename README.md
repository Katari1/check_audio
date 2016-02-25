# check_audio.sh


This was created for some troubleshooting I had to do at work.  This is my first real script in Python that I created on my own for a real problem at work.  I wrote a shitty bash script to do this that took a few hours.  This takes a few seconds to parse around 70k files.


V1 goes through a list and compares the file but is inefficient as it goes through all the files for each unique identifier.
V2 takes the files and puts it in a dictionary and then only searches the files with the set unique identifier.  Much faster.
V3 I hope will include a menu, be more object oriented etc.
