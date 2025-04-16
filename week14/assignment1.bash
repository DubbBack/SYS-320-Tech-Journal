#! /bin/bash
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
function displayAllLoc() {
echo -n "Please enter room to look for classes: "
read givenLoc

echo ""
echo "Courses in $givenLoc :" 
cat "$courseFile" | grep "$givenLoc" | cut -d';' -f1,2,10 | sort -n | \
sed 's/;/ | /g'
echo ""

}

# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas
function displayAvailable() {
echo -n "Please enter a course number (ex. ACC)"
read courseNum

echo ""
echo "Available classes for course $courseNum"
classList=$(cat "$courseFile" | grep "$courseNum")

echo "$classList" | while read -r line;
do 
	num=$(echo "$line" | cut -d';' -f4)
	if [ $num -gt 0 ]; then
	echo "$line" | cut -d';' -f1,2,4 | sed 's/;/ | /g'
	fi
done
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display all courses in given location"
	echo "[4] Display all courses with availablity"
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
		displayAllLoc

	elif [[ "$userInput" == "4" ]]; then
		displayAvailable

	else 
		echo "Please enter a vailid option"
		read userInput
	# TODO - 3 Display a message, if an invalid input is given
	fi
done
