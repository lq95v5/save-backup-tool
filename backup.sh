#!/bin/bash
dest_dir=${HOME}
TMPDIR=`mktemp -d /tmp/$0.XXXXXX`
if [ $? -ne 0 ]
then
	echo "$0: Can't create temp file, exiting..."
	exit 1
fi
mkdir -p ${TMPDIR}/$(date -I)
if [ ! -s file_list ]
then
	echo -e "Your file_list file is empty\n"
	echo -e "Please fill your path to file_list" 
fi
for path in $(cat file_list| grep -v "#")
do
	temp_file=${TMPDIR}/$(date -I)/$(readlink -f $path | sed 's/^\///g ; s/\//_/g')_backup-$(date +%H-%M-%S).tar.gz
	dest_file=${dest_dir}/$(date -I)/$(readlink -f $path | sed 's/^\///g ; s/\//_/g')_backup-$(date +%H-%M-%S).tar.gz
	(tar cvzf $temp_file $path) > /dev/null 2>&1
	echo -e "${dest_file}  has created"
done
	cp -r ${TMPDIR}/* ${dest_dir} 
