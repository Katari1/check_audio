__author__ = 'vnagrani'

import os
import sys

path = sys.argv[1]
files = os.listdir(path)
data = {}
results = {}
oneway = 0
otherway = 0
for filez in files:
    a = filez.split('__')
    a = a[0].strip()
    key = a
    data.setdefault(key, [])
    data[key].append(str(filez))

for keys,values in data.iteritems():
    NN = 0
    NF = 0
    FF = 0
    FN = 0
    results.setdefault(keys, [])
    for i in values:
            i=i.split('__')
            if i[3] == 'NEAR' and i[5] == 'NEAR':
                NN += 1
            elif i[3] == 'FAR' and i[5] == 'FAR':
                FF +=1
            elif i[3] == 'NEAR' and i[5] == 'FAR':
                NF += 1
            elif i[3] == 'FAR' and i[5] == 'NEAR':
                FN +=1
    if NF > 0 and FN == 0 and FF ==0 and NN == 0:
                oneway +=1
    if NF == 0 and FN > 0 and FF ==0 and NN == 0:
                otherway +=1


print "Total Near Only Calls: %s" %oneway
print "Total Far Only Calls: %s" %otherway


