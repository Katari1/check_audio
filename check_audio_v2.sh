__author__ = 'vnagrani'

import os
import sys

path = sys.argv[1]
files = os.listdir(path)
data = {}
results = {}

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
    print "*******************%s*********************" % keys
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

    if NN > 0:
        print "NEAR/NEAR--->",NN
        results[keys].append(str("NEAR:NEAR:" + str(NN)))
    if FF > 0:
        print "FAR/FAR----->",FF
        results[keys].append(str("FAR:FAR:" + str(FF)))
    if NF > 0:
        print "NEAR/FAR---->",NF
        results[keys].append(str("NEAR:FAR:" + str(NF)))
    if FN > 0:
        print "FAR/NEAR---->",FN
        results[keys].append(str("FAR:NEAR:" + str(FN)))



