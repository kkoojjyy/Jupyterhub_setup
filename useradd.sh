#!/bin/bash

# Add lecturers group
groupadd lecturers
groupadd py2017a
groupadd py2017b

# Add lecturer users
while IFS=, read NAME PW; do
    echo "Creating lecturer $NAME"
    if [ -z $PW ]; then
        useradd -s "/bin/bash" -m -N -g user -G sudo,adm,lecturers $NAME
		echo "$NAME password unset"
    else
        useradd -s "/bin/bash" -m -N -g users -G sudo,adm,lecturers -p "$PW" $NAME
		echo "$NAME:$PW" | chpasswd
    fi
done < <(egrep -v '^#' data/lecturers.list)

# Add regular users
while IFS=, read NAME PW; do
    echo "Creating student $NAME"
    if [ -z $PW ]; then
        useradd -s "/bin/bash" -m -N -g users -G py2017a $NAME
		echo "$NAME password unset"
    else
        useradd -s "/bin/bash" -m -N -g users -G py2017a -p "$PW" $NAME
		echo "$NAME:$PW" | chpasswd
    fi
done < <(egrep -v '^#' data/pya.list)

while IFS=, read NAME PW; do
    echo "Creating student $NAME"
    if [ -z $PW ]; then
        useradd -s "/bin/bash" -m -N -g users -G py2017b $NAME
		echo "$NAME password unset"
    else
        useradd -s "/bin/bash" -m -N -g users -G py2017b -p "$PW" $NAME
		echo "$NAME:$PW" | chpasswd
    fi
done < <(egrep -v '^#' data/pyb.list)