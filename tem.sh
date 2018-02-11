#!/bin/bash

# Add regular users
while IFS=, read NAME PW; do
    echo "Copy files to $NAME"
	cp -r ~/Chapter4_Modules /home/$NAME/lecture_notes
	chown $NAME /home/$NAME/lecture_notes/Chapter4_Modules/
	chown $NAME /home/$NAME/lecture_notes/Chapter4_Modules/*
	chgrp users /home/$NAME/lecture_notes/Chapter4_Modules/
	chgrp users /home/$NAME/lecture_notes/Chapter4_Modules/*
done < <(egrep -v '^#' data/pya.list)

while IFS=, read NAME PW; do
    echo "Copy files to $NAME"
	cp -r ~/Chapter4_Modules /home/$NAME/lecture_notes
	chown $NAME /home/$NAME/lecture_notes/Chapter4_Modules/
	chown $NAME /home/$NAME/lecture_notes/Chapter4_Modules/*
	chgrp users /home/$NAME/lecture_notes/Chapter4_Modules/
	chgrp users /home/$NAME/lecture_notes/Chapter4_Modules/*
done < <(egrep -v '^#' data/pyb.list)