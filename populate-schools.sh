#!/bin/bash

set -e

USERNAME=$1
HOSTNAME=$2
PASSWORD=$3
DB_NAME=$4
SCHOOLS=('Liceo Matovelle' 'Liceo Maradona' 'Gimnasio Fulanita' 'Hiperopatético Mayita' 'Colegio San Benito')
ADDRESSES=('Cll 170 #36-62' 'Cra 26 #52-12' 'Diag 32 #8A-20' 'Cra 113 #15-23' 'Cll 25B #112-15')

for ((i=0;i<5;i++))
do
    mysql -u $USERNAME -h $HOSTNAME -p$PASSWORD $DB_NAME  -e "INSERT INTO schools(Name, Address) VALUES('${SCHOOLS[$i]}', '${ADDRESSES[$i]}')"
done
