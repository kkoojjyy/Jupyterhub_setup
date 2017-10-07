#!/bin/bash

# Delete lecturers group
groupdel lecturers

# Delete lecturer users
while IFS=, read NAME PW; do
    echo "Delete lecturer $NAME"
    userdel $NAME
	rm -rf /home/$NAME
done < <(egrep -v '^#' lecturers.list)

# Add regular users
while IFS=, read NAME PW; do
    echo "Delete student $NAME"
	userdel $NAME
	rm -rf /home/$NAME
done < <(egrep -v '^#' students.list)

