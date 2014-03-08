
# A quick peek at various elements of the data

from lifeBuckets import lifeBuckets
from itertools import chain
import csv
import matplotlib.pyplot as plt

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
# a look at where I used the role Social
# frequency graph by life bucket
socialFID = open('dataViews\socialRole.txt', 'r')
reader = csv.DictReader( socialFID, fieldnames = ["date", "role", "goal1", "goal2", "goal3", "goal4"], 
									delimiter='\t' )

# count life buckets by date
countLifeBuckets = dict.fromkeys( lifeBucketToDate.keys(), 0 )
for row in reader:
	date = cnvDate(row['date'])
	countLifeBuckets[ dateToLifeBucket[date] ] += 1

print "Count life buckets"
#print countLifeBuckets
print sum( countLifeBuckets.values() )
print "--------"

socialFID.close()

#==============================================================
# a look at roles by life bucket

allRolesFID = open('dataViews\\allRoles.txt', 'r')
allRolesReader = csv.DictReader( allRolesFID, fieldnames = ["date", "role", "goal-1", "goal-2", "goal-3", "goal-4"], 
									delimiter='\t' )

rolesLifeBuckets = dict.fromkeys( lifeBucketToDate.keys(), [] )
for row in allRolesReader:
	date = cnvDate(row['date'])
	role = row['role']
	if role:
		rolesLifeBuckets[ dateToLifeBucket[date] ].append( role )

print "Roles by life bucket"
#print rolesLifeBuckets
print "-------------"

#==============================================================
# a look at common roles frequency by plotting by date

commonRoles =  ["personal", "other", "college", "robo", "proj.", "crew",
				"stuco", "robot", "career", "surg", "fencing", "school", 
				"social", "sac", "bsa", "finance", "family", "oa", "mobot", 
				"ac", "courses", "activities", "build 18", "email", "fix", 
				"home", "research", "sla", "bot", "compt.", "halt", 
				"leader", "room", "scholar", "troop", "finances", "fun", 
				"house", "oa brotherhood", "purchase", "work"]


# reset to head of file
allRolesFID.seek(0)

commonRolesFreq = dict.fromkeys( commonRoles, None )

for row in allRolesReader:
	date = row['date']
	role = row['role']
	if role in commonRoles:
		dates = commonRolesFreq[ role ]
		if dates == None:
			dates = []			
		dates.append(date)
		commonRolesFreq[ role ] = dates

print "Common roles date freq"
# for k in commonRolesFreq.keys():
# 	print k , len(commonRolesFreq[k])
print "-------------"

allRolesFID.close()

#==============================================================
# a look at common roles frequency by plotting by date

allRolesFID = open('dataViews\\roleDateFreq.txt', 'r')
allRolesReader = csv.reader( allRolesFID, delimiter='\t' )

# generate scatter plot X, Y and Labels
Labels = []
X = []
Y = []
rowNum = 1
for row in allRolesReader:
	Labels.append( row[0] )
	X += map(int, row[1:])
	Y += [rowNum] * (len(row) - 1)
	rowNum += 1

print X
print Y
print Labels
print "--------"

plt.scatter(X,Y)
plt.show()

#==============================================================
# a look at where I wrote "fun" in a goal
# frequency graph by life bucket
funFID = open('dataViews\\funGoals.txt', 'r')
reader = csv.DictReader( funFID, fieldnames = ["date", "goal"], 
									delimiter='\t' )

# count life buckets by date
countLifeBuckets = dict.fromkeys( lifeBucketToDate.keys(), 0 )
for row in reader:
	date = cnvDate(row['date'])
	countLifeBuckets[ dateToLifeBucket[date] ] += 1

print "Count life buckets for 'fun'"
print countLifeBuckets
print sum( countLifeBuckets.values() )
print "--------"

funFID.close()
