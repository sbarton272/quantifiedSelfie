
# rename all #-f/b.jpg with correct date

rootdir = '../weeklyPlanners/seperated/jpg'

import os, csv

with open("fileDateNames.txt") as fileNames:
    fileNamesReader = csv.reader(fileNames, delimiter='\t')

    for row in fileNamesReader:
        date = row[1] + '-' + row[2] + '-' + row[3]
        
        for ex in ['f', 'b']:
            oldName = row[0] + '-' + ex + '.jpg'
            newName = date + '-' + ex + '.jpg'
            print oldName, newName
            os.rename( rootdir + '/' + oldName, rootdir + '/' + newName)
