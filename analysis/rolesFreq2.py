# new attempt at roles catagorization
# it is a bit to late at night :(

from lifeBuckets import lifeBuckets
from itertools import chain
from operator import itemgetter
import csv

def cnvDate(date):
	[m,d,y] = map(int,date.split('/'))
	return (m,d,y)

#==============================================================
# create reverse of life buckets: date -> life bucket
lifeBucketToDate = lifeBuckets
allDates = list(chain.from_iterable( lifeBucketToDate.values() ))
dateToLifeBucket = dict.fromkeys( allDates, 0 )
for k,dates in lifeBucketToDate.items():
	# fill new dict with life bucket
	for date in dates:
		dateToLifeBucket[date] = k

#==============================================================
# a look at roles by life bucket

allRolesFID = open('dataViews\\allRoles.txt', 'r')
allRolesReader = csv.DictReader( allRolesFID, fieldnames = ["date", "role", "goal-1", "goal-2", "goal-3", "goal-4"], 
									delimiter='\t' )

rolesLifeBuckets = dict.fromkeys( lifeBucketToDate.keys(), None )
allRoles = []
for row in allRolesReader:
	# extract elements
	date = cnvDate(row['date'])
	role = row['role']
	# if role blank continue
	if not role:
		continue

	if role not in allRoles:
		allRoles.append( role )
	
	bucket = dateToLifeBucket[date]

	# get refrence to bucket rolesData
	rolesData = rolesLifeBuckets[bucket]

	if rolesData == None:
		rolesData = []
	rolesData.append(role)
	rolesLifeBuckets[bucket] = rolesData

roleCount = dict.fromkeys( allRoles, None )
buckets = ["Fall Senior HS", "Spring Senior HS", "Fall Freshman", "Spring Freshman", "Summer Freshman", "Fall Sophmore", "Spring Sophmore", "Summer Sophmore", "Fall Junior", "Spring Junior"]
for i in xrange(len(buckets)):
	bucket = buckets[i]

	for role in rolesLifeBuckets[bucket]:

		if roleCount[role] == None:
			roleCount[role] = [0] * len(buckets)
		roleCount[role][i] += 1

for k, v in roleCount.items():
	name = k.replace(' ', '_').replace('/','_').replace('.','2').replace('=','4').replace(',','1')
	print '\tInteger[] counts_' + name + ' = {' + str(v)[1:-1] + '};'
	print '\tRoleCount.put("' + k +'", ' + 'counts_' + name + ');'