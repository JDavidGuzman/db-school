#!/bin/bash

set -e

USERNAME=$1
HOSTNAME=$2
PASSWORD=$3
DB_NAME=$4 

echo "Create DB"
mysql -u $USERNAME -h $HOSTNAME -p$PASSWORD < school-table.sql
echo "DB created"
echo "Populate DB"
bash populate-schools.sh $USERNAME $HOSTNAME $PASSWORD $DB_NAME
bash populate-teachers.sh $USERNAME $HOSTNAME $PASSWORD $DB_NAME
bash populate-students.sh $USERNAME $HOSTNAME $PASSWORD $DB_NAME
