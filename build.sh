#!/bin/bash

if [[ -z $1 ]]; then
    echo " Version paramater is requried."
    exit 1
fi

rm -f biobtree_MacOS_64bit.tar.gz

bbLatestVersion=`curl -Ls -o /dev/null -w %{url_effective} https://github.com/tamerh/biobtree/releases/latest | rev | cut -d '/' -f 1 | rev`

curl -OL https://github.com/tamerh/biobtree/releases/download/$bbLatestVersion/biobtree_MacOS_64bit.tar.gz 

tar -xzvf biobtree_MacOS_64bit.tar.gz

./biobtree -d hgnc,uniprot,hmdb,taxonomy,go,efo,eco,chebi,interpro --keep --idx cache$1 update

rm biobtree
rm biobtree_MacOS_64bit.tar.gz

cd ..


#tar --exclude 'biobtree-conf/.git' --exclude 'biobtree-conf/build.sh' --exclude 'biobtree-conf/.gitignore' --exclude 'biobtree-conf/notes.txt' -zcvf biobtree-conf-0.99.1.tar.gz biobtree-conf 

zip -9 -r --exclude=*.git* --exclude=*build.sh --exclude=*notes.txt --exclude=*.DS_Store* biobtree-conf-$1.zip *
