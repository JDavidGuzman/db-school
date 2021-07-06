#!/bin/bash

set -e

USERNAME=$1
HOSTNAME=$2
PASSWORD=$3
DB_NAME=$4 

IFS=,

SUBJECT=(Math Biology Chemistry Physics Languages Arts Sports Politics)

SCHOOL_COUNTER=1
COURSE_COUNTER=1
SUBJECT_COUNTER=0

while read FIRSTNAME LASTNAME EMAIL
do 

    if [ $COURSE_COUNTER -gt 11 ]
    then
        COURSE_COUNTER=1
        let SCHOOL_COUNTER=SCHOOL_COUNTER+1
    fi

    case $COURSE_COUNTER in
        1) LEVEL="st";;
        2) LEVEL="nd";;
        3) LEVEL="rd";;
        *) LEVEL="th";;
    esac

    if [ $SUBJECT_COUNTER -gt 7 ]
    then
        SUBJECT_COUNTER=0
    fi

    mysql -u $USERNAME -h $HOSTNAME -p$PASSWORD $DB_NAME -e "INSERT INTO teachers(School_ID, Level, Firstname, Lastname, Email, Subject) Values('$SCHOOL_COUNTER', '$COURSE_COUNTER$LEVEL', '$FIRSTNAME', '$LASTNAME', '$EMAIL', '${SUBJECT[$SUBJECT_COUNTER]}')"
    echo "Teacher added"

    let COURSE_COUNTER=COURSE_COUNTER+1
    let SUBJECT_COUNTER=SUBJECT_COUNTER+1
done < data/teachers.csv 
