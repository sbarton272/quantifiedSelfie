
# find dates in scans

rootdir = '../weeklyPlanners/seperated/jpg'

import os, re
import Image

files = []
for f in os.listdir(rootdir):
    m = re.match("(\d+)-(\w).jpg", f)
    if m:
        d = int(m.group(1))
        files.append(d)

files = list(set(files))
files.sort()
print files

for f in files:
    print f
    im = Image.open( rootdir + '/' + str(f) + "-f.jpg" )
    box = (2600, 200, 4200, 500)
    out = im.crop(box)
    out = out.resize((1000,200))
    out.show()

print 'done'
