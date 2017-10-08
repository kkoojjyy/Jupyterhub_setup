#!/bin/bash

# Delete lecturers group
groupdel lecturers
groupdel users
groupdel py2017a
groupdel py2017b

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