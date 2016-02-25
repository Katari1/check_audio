__author__ = 'vnagrani'

import os
import sys
#import fnmatch
#import re

path = sys.argv[1]
#path = "/tmp/test"
tmp_file='tmp.txt'
files = os.listdir(path)
original=[]
unique = []
dir_listing = []
data = {}
NN = 0
NF = 0
FF = 0
FN = 0

#Open tmp file
#tmp = open(tmp_file, 'w')

#Loop through for unique identifier
for filez in files:
    b =filez.split('__')
    original.append(b[0])
    dir_listing.append(b)

#Get rid of duplicate Unique Identifiers
unique = set(original)

#Put directory listings into set
#for i in files:
#    tmp.write(i)
#    tmp.write("\n")

#Closing tmp file for write
#tmp.close()
#Opening tmp for read
#tmp = open(tmp_file, 'r')
for i in unique:
    print i
    for z in dir_listing:
        #print i
        #print z[3],z[5]
        if i in z and z[3] == 'NEAR' and z[5] == 'NEAR':
            NN += 1
        elif i in z and z[3] == 'FAR' and z[5] == 'FAR':
            FF +=1
        elif i in z and z[3] == 'NEAR' and z[5] == 'FAR':
            NF += 1
        elif i in z and z[3] == 'FAR' and z[5] == 'NEAR':
            FN += 1
        #else:
            #print "You're a fucking idiot"
        #elif i in z and re.compile("^[^\s]*FAR[^\s]*\sFAR[^\s]*$"):
            #FF +=1
        #elif i in z and re.compile("^[^\s]*FAR[^\s]*\sNEAR[^\s]*$"):
            #FN +=1
        #elif i in z and re.compile("^[^\s]*NEAR[^\s]*\sFAR[^\s]*$"):
            #NF +=1
    if NN > 0:
        print "NEAR/NEAR: ", NN
    if FF > 0:
        print "FAR/FAR: ", FF
    if NF > 0:
        print "NEAR/FAR: ", NF
    if FN > 0:
        print "FAR/NEAR: ", FN

    NN = 0
    NF = 0
    FF = 0
    FN = 0
    #tmp.seek(0)