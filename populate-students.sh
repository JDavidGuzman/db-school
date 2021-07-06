#!/bin/bash

set -e 

USERNAME=$1
HOSTNAME=$2
PASSWORD=$3
DB_NAME=$4

IFS=,

COUNTER=1
STUDENT_COUNTER=1
SCHOOL_COUNTER=1
COURSE_COUNTER=1

while read FIRSTNAME LASTNAME EMAIL
do 

    if [ $STUDENT_COUNTER -gt 30 ]
    then
        STUDENT_COUNTER=1
        let COURSE_COUNTER=COURSE_COUNTER+1
        if [ $COURSE_COUNTER -gt 11 ]
        then
            COURSE_COUNTER=1
            let SCHOOL_COUNTER=SCHOOL_COUNTER+1
        fi
    fi

    case $COURSE_COUNTER in
        1) LEVEL="st";;
        2) LEVEL="nd";;
        3) LEVEL="rd";;
        *) LEVEL="th";;
    esac

    mysql -u $USERNAME -h $HOSTNAME -p$PASSWORD $DB_NAME -e "INSERT INTO students(School_ID, Level, Firstname, Lastname, Email) Values('$SCHOOL_COUNTER', '$COURSE_COUNTER$LEVEL', '$FIRSTNAME', '$LASTNAME', '$EMAIL')"
    echo "Student added"    
    mysql -u $USERNAME -h $HOSTNAME -p$PASSWORD $DB_NAME -e "INSERT INTO grades(Student_ID, School_ID, Level) Values('$COUNTER', '$SCHOOL_COUNTER', '$COURSE_COUNTER$LEVEL')"
    echo "Grades added"

    for SUBJECT in Math Biology Chemistry Physics Languages Arts Sports Politics
    do
        GRADE_1=$((1 + $RANDOM % 5))
        if [ $GRADE_1 -eq 5 ]
        then
            GRADE_2=0
        else
            GRADE_2=$(($RANDOM % 10)) 
        fi

        mysql -u $USERNAME -h $HOSTNAME -p$PASSWORD $DB_NAME -e "UPDATE grades SET $SUBJECT = $GRADE_1.$GRADE_2 WHERE Student_ID = $COUNTER"
        echo "$SUBJECT subject scored for student ID $COUNTER"
    done

    let STUDENT_COUNTER=STUDENT_COUNTER+1
    let COUNTER=COUNTER+1
done < data/students.csv 
