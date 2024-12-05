#! /bin/bash

# Deliverable 1

# xmlstarlet format --html --recover 2>/dev/null
# xmlstarlet format is the xmlstarlet command that formats XML or HTML input, the --html indicates that it is the latter being formatted here
# --recover tells the program to recover the information that is parsable, while 2>/dev/null tells the program to redirect any error messages to /dev/null

# xmlstarlet select --template --copy-of "//html//body//div//div//table//tr"
# xmlstarlet select is the xmlstarlet command that queries or selects data in XML or HTML documents using XPath
# --template tells the program that you are specifying what content is being selected as opposed to only selecting the nodes
# --copy-of tells the program to print a copy of the XPath. This differs from --value-of, where only the text content is printed as opposed to the whole XPath.
# "//html//body//div//div//table//tr" is the XPath that is being copied

clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas
function displayCourseInRoom(){
	echo -n "Please Input a Room Name: "
	read roomName

	echo ""
	echo "Courses in $roomName: "
	cat "$courseFile" | grep "$roomName" | cut -d';' -f1,2,5,6,7 | sed 's/;/ | /g'
	echo ""
}


# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas
function displayOpenCourse(){
	echo -n "Please Input a Course Code: "
	read courseCode

	echo ""
	echo "$courseCode with open steats:"
	temp=$(cat "$courseFile" | cut -d';' -f1 | grep "$courseCode" | uniq)
	courses=()
	for i in "${temp[@]}":
	do
		courses+=$(cat "$courseFile" | grep "$i" | sed 's/;/ | /g')
	done
	echo "$courses"
	echo ""
}



while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses in a room"
	echo "[4] Display available courses of a subject"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		displayCourseInRoom

	elif [[ "$userInput" == "4" ]]; then
		displayOpenCourse

	# TODO - 3 Display a message, if an invalid input is given
	else
		echo "Invalid Input! Please select a valid option"
	fi
done
