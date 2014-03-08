# new attempt at roles catagorization
# it is a bit to late at night :(

from lifeBuckets import lifeBuckets
from itertools import chain
from operator import itemgetter
import csv

def cnvDate(date):
	[m,d,y] = map(int,date.split('/'))
	return (m,d,y)

def getGoals(goal1, goal2, goal3, goal4):
	goals = []
	if goal1: goals += [goal1]
	if goal2: goals += [goal2]
	if goal3: goals += [goal3]
	if goal4: goals += [goal4]
	return goals

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
	# extract elements
	date = cnvDate(row['date'])
	role = row['role']
	# if role blank continue
	if not role:
		continue
	goals = getGoals( row['goal-1'], row['goal-2'], row['goal-3'], row['goal-4'] )
	bucket = dateToLifeBucket[date]

	# get refrence to bucket rolesData
	rolesData = rolesLifeBuckets[bucket]

	if rolesData == None:
		rolesData = dict()

	# new role
	if role not in rolesData:
		rolesData[role] = dict(role = role, count= 1, goals= goals)
	else:
		rolesData[role]['count'] += 1
		rolesData[role]['goals'] += goals

	rolesLifeBuckets[bucket] = rolesData

# sort roles by count
for bucket in rolesLifeBuckets.keys():
	rolesList = rolesLifeBuckets[bucket].values()
	rolesList.sort(key=itemgetter('count'), reverse=True)
	rolesLifeBuckets[bucket] = rolesList

for bucket in rolesLifeBuckets.keys():
	print bucket, rolesLifeBuckets[bucket]