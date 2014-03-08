
# rename all planner#.jpg to planner-1-#.jpg

rootdir = '../weeklyPlanners/seperated/jpg'

import os, re

for f in os.listdir(rootdir):
    m = re.match("planner(\d+).jpg", f)
    if m:
        newf = "planner-1-" + str(m.group(1)) + ".jpg"
        print f, newf
        os.rename( rootdir + '/' + f, newf)

