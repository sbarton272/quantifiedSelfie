
# a quick look at the spread of dates
# save all filenames (dates) in csv

rootdir = '../weeklyPlanners/seperated/jpg'

import os, csv, re

csvfile = open('dates.csv', 'wb')
writer = csv.writer(csvfile)

writer.writerow(['year', 'month', 'day'])

# to check that there are both a front and back file for all dates:
filesSeen = []
for f in os.listdir(rootdir):
    m = re.match("(\d+)-(\d+)-(\d+)-([bf]).jpg", f)

    if m:
               
        # extract date
        year = m.group(1)
        month = m.group(2)
        day = m.group(3)
        side = m.group(4)
        print year, month, day, side

        # add filename if not in filesSeen, otherwise remove
        # filesSeen should be empty by the end
        i = (year, month, day)
        if i in filesSeen:
            filesSeen.remove(i)
        else:
            filesSeen.append(i)
            # write to csv year, month, day first time date seen
            writer.writerow([year, month, day])


print len(filesSeen) == 0
