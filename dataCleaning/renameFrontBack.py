
# rename all planner-1-#.jpg to #-f/b.jpg

rootdir = '../weeklyPlanners/seperated/jpg'

import os, re

num = 1
seen = []
for f in os.listdir(rootdir):
    m = re.match("(\d+)-(\w).jpg", f)

    if m:
               
        # extract num
        n = int(m.group(1))
        fb = m.group(2)

        newf = str( num ) + '-'
        newf += fb
        newf += ".jpg"
        print  f + '\t' + newf
        os.rename( rootdir + '/' + f, rootdir + '/' + newf)

        if n in seen:
        	num += 1
       	else:
       		seen.append(n)

