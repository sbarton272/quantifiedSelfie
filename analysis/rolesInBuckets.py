
# A quick peek at various elements of the data

from lifeBuckets import lifeBuckets
from itertools import chain
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
for row in allRolesReader:
	date = cnvDate(row['date'])
	role = row['role']
	if role:
		data = rolesLifeBuckets[ dateToLifeBucket[date] ]
		if data == None:
			rolesLifeBuckets[ dateToLifeBucket[date] ] = []
		goals = [row['goal-1'], row['goal-2'], row['goal-3'], row['goal-4']]
		roleData = {'role': role, 'goals': goals }
		rolesLifeBuckets[ dateToLifeBucket[date] ].append( roleData )

# combine roles to determine counts and goals
for bucket in rolesLifeBuckets.keys():
	roleData = rolesLifeBuckets[bucket]
	# find all roles
	newRoleData = dict()
	for rD in roleData:
		role = rD['role']
		if role not in newRoleData:
			# first occurance of role
			newRoleData[role] = {'role': role, 'count': 0, 'goals': []}
		else:
			# another occurance of role
			newRoleData[role]['count'] += 1
			newRoleData[role]['goals'] += rD['goals']
	rolesLifeBuckets[bucket] = newRoleData

for k in rolesLifeBuckets.keys():
	roleData = rolesLifeBuckets[k]
	orderedRoles = sorted(roleData, key=roleData.get)[::-1]
	roleList = []
	for role in orderedRoles:
		roleList += roleData[role]
		print roleData[role]
	# print k, roleList

# get top 5 per bucket
