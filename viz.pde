
/* Processing plot life buckets and ordered roles */

import java.util.*;

HashMap<String,String[]> RolesByBucket = new HashMap<String,String[]>();
String[] labelOrd = {"Fall Senior HS", "Spring Senior HS", "Fall Freshman", "Spring Freshman", "Summer Freshman", "Fall Sophmore", "Spring Sophmore", "Summer Sophmore", "Fall Junior", "Spring Junior"};
HashMap<String,Integer[]> RoleCount = new HashMap<String,Integer[]>();

// sizing
int winX = 800;
int winY = 800;
int margin = 20;
int topBorder = 50;
int textPadding = 3;
int fontSize = 14;
int maxBucketLen;
String selected = "";
int scaleCount = 7;
int tickLen = 15;
Integer[] counts;
String title = "A Catagorization of Spencer's Life";

/*===================================================
  Setup
  =================================================== */

void setup() {
	fillRolesByBucket();

	int mx = 0;
	for(int i = 0; i < labelOrd.length; i++) {
		mx = max(mx, labelOrd[i].length() );
	}
	maxBucketLen = mx;

	winX = fontSize*maxBucketLen*labelOrd.length;
	size(winX, winY);

}

void fillRolesByBucket() {
	
	String[] roles1 = {"personal", "sac", "stuco", "robo", "career", "other", "bot", "halt", "build 18", "fencing", "social", "stucco", "acodev", "courses", "ac", "surg", "building"};
	RolesByBucket.put( "Fall Junior" , roles1 );
	
	String[] roles2 = {"personal", "surg", "stuco", "fencing", "finance", "other", "robo", "ac", "room", "build 18", "proj.", "email", "social", "harrison", "france", "buy"};		
	RolesByBucket.put( "Spring Sophmore" , roles2 );
	
	String[] roles3 = {"college", "crew", "robot", "other", "personal", "leader", "fencing", "service chair", "school", "student", "social", "leadership", "grandson", "team pres.", "stud phys", "driver", "stud hist", "stud calc", "stud spanish", "service", "leadership course", "son/personal", "crew pres.", "son", "robotics", "fence"};		
	RolesByBucket.put( "Fall Senior HS" , roles3 );
	
	String[] roles4 = {"surg", "other", "home", "personal", "finances", "personal/home", "fencing", "proj.", "social", "job", "oc", "projs"};		
	RolesByBucket.put( "Summer Freshman" , roles4 );
	
	String[] roles5 = {"personal", "college", "robot", "crew", "bsa", "oa", "other", "school", "family", "sla", "troop", "scholar", "fencing", "oa brotherhood", "big", "nylt", "ap", "class", "enclear", "ca", "class cab", "class cab.", "mbs", "thanks", "crewoa", "college comparison"};		
	RolesByBucket.put( "Spring Senior HS" , roles5 );
	
	String[] roles6 = {"career", "personal", "social", "robo", "courses", "activities", "compt.", "fencing", "house", "activities/social", "school", "outside", "tutor new", "social/activities", "career, etc.", "room", "old/home", "purchase", "jobs/summer", "friends", "hc", "career etc", "shlag", "opp.", "other", "tutor", "room/personal", "home", "career/per"};		
	RolesByBucket.put( "Fall Freshman" , roles6 );
	
	String[] roles8 = {"proj.", "mobot", "stuco", "fun", "robo", "work", "personal", "other", "calls", "old"};		
	RolesByBucket.put( "Summer Sophmore" , roles8 );
	
	String[] roles10 = {"robo", "personal", "research", "sac", "housing"};		
	RolesByBucket.put( "Spring Junior" , roles10 );
	
	String[] roles11 = {"personal", "other", "proj.", "school", "email", "groups", "career", "robo", "surg", "social", "reflect", "research", "jobs", "ac", "project"};		
	RolesByBucket.put( "Fall Sophmore" , roles11 );
	
	String[] roles12 = {"personal", "proj.", "other", "career", "social", "fix", "robo", "email", "purchase", "finance", "school", "projects", "finances", "courses", "buy", "activities"};		
	RolesByBucket.put( "Spring Freshman" , roles12 );

	Integer[] counts_compt2 = {0, 0, 4, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("compt.", counts_compt2);
	Integer[] counts_thanks = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("thanks", counts_thanks);
	Integer[] counts_harrison = {0, 0, 0, 0, 0, 0, 1, 0, 0, 0};
	RoleCount.put("harrison", counts_harrison);
	Integer[] counts_crew_pres2 = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("crew pres.", counts_crew_pres2);
	Integer[] counts_projs = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0};
	RoleCount.put("projs", counts_projs);
	Integer[] counts_personal = {11, 20, 8, 15, 4, 13, 15, 2, 15, 5};
	RoleCount.put("personal", counts_personal);
	Integer[] counts_fix = {0, 0, 0, 5, 0, 0, 0, 0, 0, 0};
	RoleCount.put("fix", counts_fix);
	Integer[] counts_outside = {0, 0, 2, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("outside", counts_outside);
	Integer[] counts_nylt = {0, 2, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("nylt", counts_nylt);
	Integer[] counts_robo = {0, 0, 7, 2, 0, 2, 5, 2, 12, 5};
	RoleCount.put("robo", counts_robo);
	Integer[] counts_activities = {0, 0, 4, 1, 0, 0, 0, 0, 0, 0};
	RoleCount.put("activities", counts_activities);
	Integer[] counts_finance = {0, 0, 0, 2, 0, 0, 7, 0, 0, 0};
	RoleCount.put("finance", counts_finance);
	Integer[] counts_big = {0, 2, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("big", counts_big);
	Integer[] counts_halt = {0, 0, 0, 0, 0, 0, 0, 0, 4, 0};
	RoleCount.put("halt", counts_halt);
	Integer[] counts_projects = {0, 0, 0, 1, 0, 0, 0, 0, 0, 0};
	RoleCount.put("projects", counts_projects);
	Integer[] counts_school = {2, 6, 2, 2, 0, 6, 0, 0, 0, 0};
	RoleCount.put("school", counts_school);
	Integer[] counts_old_home = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("old/home", counts_old_home);
	Integer[] counts_scholar = {0, 4, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("scholar", counts_scholar);
	Integer[] counts_email = {0, 0, 0, 2, 0, 2, 1, 0, 0, 0};
	RoleCount.put("email", counts_email);
	Integer[] counts_room_personal = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("room/personal", counts_room_personal);
	Integer[] counts_troop = {0, 4, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("troop", counts_troop);
	Integer[] counts_social_activities = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("social/activities", counts_social_activities);
	Integer[] counts_proj2 = {0, 0, 0, 9, 1, 6, 2, 12, 0, 0};
	RoleCount.put("proj.", counts_proj2);
	Integer[] counts_calls = {0, 0, 0, 0, 0, 0, 0, 1, 0, 0};
	RoleCount.put("calls", counts_calls);
	Integer[] counts_old = {0, 0, 0, 0, 0, 0, 0, 1, 0, 0};
	RoleCount.put("old", counts_old);
	Integer[] counts_fence = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("fence", counts_fence);
	Integer[] counts_house = {0, 0, 3, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("house", counts_house);
	Integer[] counts_college = {17, 18, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("college", counts_college);
	Integer[] counts_home = {0, 0, 1, 0, 4, 0, 0, 0, 0, 0};
	RoleCount.put("home", counts_home);
	Integer[] counts_leadership_course = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("leadership course", counts_leadership_course);
	Integer[] counts_courses = {0, 0, 4, 1, 0, 0, 0, 0, 1, 0};
	RoleCount.put("courses", counts_courses);
	Integer[] counts_research = {0, 0, 0, 0, 0, 1, 0, 0, 0, 4};
	RoleCount.put("research", counts_research);
	Integer[] counts_class_cab2 = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("class cab.", counts_class_cab2);
	Integer[] counts_class_cab = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("class cab", counts_class_cab);
	Integer[] counts_leader = {4, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("leader", counts_leader);
	Integer[] counts_opp2 = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("opp.", counts_opp2);
	Integer[] counts_jobs = {0, 0, 0, 0, 0, 1, 0, 0, 0, 0};
	RoleCount.put("jobs", counts_jobs);
	Integer[] counts_personal_home = {0, 0, 0, 0, 2, 0, 0, 0, 0, 0};
	RoleCount.put("personal/home", counts_personal_home);
	Integer[] counts_job = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0};
	RoleCount.put("job", counts_job);
	Integer[] counts_leadership = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("leadership", counts_leadership);
	Integer[] counts_groups = {0, 0, 0, 0, 0, 2, 0, 0, 0, 0};
	RoleCount.put("groups", counts_groups);
	Integer[] counts_stucco = {0, 0, 0, 0, 0, 0, 0, 0, 1, 0};
	RoleCount.put("stucco", counts_stucco);
	Integer[] counts_team_pres2 = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("team pres.", counts_team_pres2);
	Integer[] counts_career = {0, 0, 10, 7, 0, 2, 0, 0, 5, 0};
	RoleCount.put("career", counts_career);
	Integer[] counts_oc = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0};
	RoleCount.put("oc", counts_oc);
	Integer[] counts_oa = {0, 8, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("oa", counts_oa);
	Integer[] counts_social = {1, 0, 7, 6, 1, 1, 1, 0, 1, 0};
	RoleCount.put("social", counts_social);
	Integer[] counts_housing = {0, 0, 0, 0, 0, 0, 0, 0, 0, 2};
	RoleCount.put("housing", counts_housing);
	Integer[] counts_family = {0, 6, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("family", counts_family);
	Integer[] counts_ca = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("ca", counts_ca);
	Integer[] counts_robotics = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("robotics", counts_robotics);
	Integer[] counts_son = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("son", counts_son);
	Integer[] counts_career_per = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("career/per", counts_career_per);
	Integer[] counts_build_18 = {0, 0, 0, 0, 0, 0, 2, 0, 2, 0};
	RoleCount.put("build 18", counts_build_18);
	Integer[] counts_crew = {15, 13, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("crew", counts_crew);
	Integer[] counts_mbs = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("mbs", counts_mbs);
	Integer[] counts_service = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("service", counts_service);
	Integer[] counts_acodev = {0, 0, 0, 0, 0, 0, 0, 0, 1, 0};
	RoleCount.put("acodev", counts_acodev);
	Integer[] counts_class = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("class", counts_class);
	Integer[] counts_tutor = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("tutor", counts_tutor);
	Integer[] counts_stud_spanish = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("stud spanish", counts_stud_spanish);
	Integer[] counts_stud_calc = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("stud calc", counts_stud_calc);
	Integer[] counts_stuco = {0, 0, 0, 0, 0, 0, 10, 6, 12, 0};
	RoleCount.put("stuco", counts_stuco);
	Integer[] counts_finances = {0, 0, 0, 1, 2, 0, 0, 0, 0, 0};
	RoleCount.put("finances", counts_finances);
	Integer[] counts_stud_hist = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("stud hist", counts_stud_hist);
	Integer[] counts_buy = {0, 0, 0, 1, 0, 0, 1, 0, 0, 0};
	RoleCount.put("buy", counts_buy);
	Integer[] counts_enclear = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("enclear", counts_enclear);
	Integer[] counts_hc = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("hc", counts_hc);
	Integer[] counts_jobs_summer = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("jobs/summer", counts_jobs_summer);
	Integer[] counts_room = {0, 0, 1, 0, 0, 0, 3, 0, 0, 0};
	RoleCount.put("room", counts_room);
	Integer[] counts_oa_brotherhood = {0, 3, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("oa brotherhood", counts_oa_brotherhood);
	Integer[] counts_work = {0, 0, 0, 0, 0, 0, 0, 2, 0, 0};
	RoleCount.put("work", counts_work);
	Integer[] counts_crewoa = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("crewoa", counts_crewoa);
	Integer[] counts_career1_etc2 = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("career, etc.", counts_career1_etc2);
	Integer[] counts_project = {0, 0, 0, 0, 0, 1, 0, 0, 0, 0};
	RoleCount.put("project", counts_project);
	Integer[] counts_shlag = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("shlag", counts_shlag);
	Integer[] counts_fun = {0, 0, 0, 0, 0, 0, 0, 3, 0, 0};
	RoleCount.put("fun", counts_fun);
	Integer[] counts_activities_social = {0, 0, 2, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("activities/social", counts_activities_social);
	Integer[] counts_sla = {0, 5, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("sla", counts_sla);
	Integer[] counts_ac = {0, 0, 0, 0, 0, 1, 4, 0, 1, 0};
	RoleCount.put("ac", counts_ac);
	Integer[] counts_sac = {0, 0, 0, 0, 0, 0, 0, 0, 13, 4};
	RoleCount.put("sac", counts_sac);
	Integer[] counts_bot = {0, 0, 0, 0, 0, 0, 0, 0, 4, 0};
	RoleCount.put("bot", counts_bot);
	Integer[] counts_college_comparison = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("college comparison", counts_college_comparison);
	Integer[] counts_ap = {0, 2, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("ap", counts_ap);
	Integer[] counts_mobot = {0, 0, 0, 0, 0, 0, 0, 7, 0, 0};
	RoleCount.put("mobot", counts_mobot);
	Integer[] counts_priorities = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("priorities", counts_priorities);
	Integer[] counts_son_personal = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("son/personal", counts_son_personal);
	Integer[] counts_fencing = {4, 4, 3, 0, 2, 0, 7, 0, 2, 0};
	RoleCount.put("fencing", counts_fencing);
	Integer[] counts_other = {12, 8, 1, 7, 5, 7, 6, 1, 4, 0};
	RoleCount.put("other", counts_other);
	Integer[] counts_service_chair = {2, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("service chair", counts_service_chair);
	Integer[] counts_surg = {0, 0, 0, 0, 7, 2, 13, 0, 1, 0};
	RoleCount.put("surg", counts_surg);
	Integer[] counts_career_etc = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("career etc", counts_career_etc);
	Integer[] counts_driver = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("driver", counts_driver);
	Integer[] counts_reflect = {0, 0, 0, 0, 0, 1, 0, 0, 0, 0};
	RoleCount.put("reflect", counts_reflect);
	Integer[] counts_france = {0, 0, 0, 0, 0, 0, 1, 0, 0, 0};
	RoleCount.put("france", counts_france);
	Integer[] counts_student = {2, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("student", counts_student);
	Integer[] counts_friends = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("friends", counts_friends);
	Integer[] counts_bsa = {0, 10, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("bsa", counts_bsa);
	Integer[] counts_building = {0, 0, 0, 0, 0, 0, 0, 0, 1, 0};
	RoleCount.put("building", counts_building);
	Integer[] counts_purchase = {0, 0, 1, 2, 0, 0, 0, 0, 0, 0};
	RoleCount.put("purchase", counts_purchase);
	Integer[] counts_grandson = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("grandson", counts_grandson);
	Integer[] counts_robot = {12, 15, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("robot", counts_robot);
	Integer[] counts_stud_phys = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("stud phys", counts_stud_phys);
	Integer[] counts_tutor_new = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0};
	RoleCount.put("tutor new", counts_tutor_new);

}

/*===================================================
  Update
  =================================================== */
void update() {
	winX = width; //displayWidth;
	winY = height; //displayHeight;
}

/*===================================================
  Draw
  =================================================== */
void draw() {

	background(0);

	textSize(fontSize);

	// plot by time periods
	int nBucket = 0;
	for ( String k : labelOrd ) {
	  fill(200);

	  int x = margin + fontSize*(maxBucketLen-5)*nBucket;
	  int y = margin + topBorder;
	  text( k, x, y );

	  // show roles
	  y += fontSize;

	  String[] roles = RolesByBucket.get(k);
	  for ( String r : roles ) {
		y += fontSize + textPadding;
		if (mouseOverText(x,y,r) || selected.equals(r) ) {
			fill(255,100,100);
			selected = r;
		} else {
			fill(200);
		}
	  	text( r, x, y );
	  }
	  nBucket++;
	}

	// draw line graph for selected
	stroke(200);
	if (!selected.equals("")) {
		counts = RoleCount.get(selected);
		for (int i = 1; i < counts.length; i++) {
			int xOff = fontSize*(maxBucketLen-5)/3 + margin;
			int x = i*fontSize*(maxBucketLen-5) + xOff;
			int y = winY - margin - counts[i]*scaleCount;
			int px = (i-1)*fontSize*(maxBucketLen-5) + xOff;
			int py = winY - margin - counts[i-1]*scaleCount;
			line( px, py, x, y);
		}
	}
	fill(200);

	// title
	// textSize(fontSize*2);
	// text(title, width/2 - title.length()*fontSize/2, topBorder - margin);
	// textSize(fontSize);
	
	// ticks
	int zeroY = winY - margin;
	line(margin, zeroY, margin+tickLen, zeroY);
	text("0", margin, zeroY - 1);

	int tenY = winY - margin - 10*scaleCount;
	line(margin, tenY, margin+tickLen, tenY);
	text("10", margin, tenY - 1);

	int twentyY = winY - margin - 20*scaleCount;
	line(margin, twentyY, margin+tickLen, twentyY);
	text("20", margin, twentyY - 1);

	int edgeX = 2*winX/3;

	line(edgeX - margin, zeroY, edgeX - margin+tickLen, zeroY);
	text("0", edgeX - margin, zeroY - 1);

	line(edgeX - margin, tenY, edgeX - margin+tickLen, tenY);
	text("10", edgeX - margin, tenY - 1);

	line(edgeX - margin, twentyY, edgeX - margin+tickLen, twentyY);
	text("20", edgeX - margin, twentyY - 1);

}

boolean mouseOverText(int x, int y, String txt) {
	int difX = mouseX - x;
	int difY = mouseY - (y - fontSize);
	return (difX >= 0 && difY >= 0 && difX <= (txt.length()*fontSize) && difY <= fontSize);
}

