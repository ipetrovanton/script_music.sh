#!/usr/bin/env bash

path="/home/thinkpad/IdeaProjects/music/"
function copyfile {
    a=""
    a=`$1 grep *.mp3`
    a=`$1 grep *.wav`
    a=`$1 grep *.flac`
    if [[ $a == ""  ]]; then
    echo $USER:`date` File $1 did not copy to $path. Format is not correct. >> $path/music.log
    echo Uncorrect format
    return
    fi
    cp $1 $path
    pwd
    ls
    return
    echo $USER:`date` File $1 copied to $path >> $path/music.log
}

function getByUrl {
    cd $path
    wget -c $1
    cd -
    cp $1 $path
    pwd
    ls
    echo $USER:`date` File $1 is downloaded to $path >> $path/music.log
    return
}
function delfile {
    rm $1
    echo file $1 was removed from `pwd`
    echo $USER:`date` File $1 is removed from $path >> $path/music.log
}

function writeSong {
    echo $1
    touch "$path""$1"
    a=""
    while [[ "$a" != "stop" ]]; do
        read a
        if [[ "$a" == "stop" ]]; then
        echo stop write in file $1
        break
        fi
        echo ${a} >> $1
    done

}

function cpto {
    echo $1
    currentAddr=`pwd`
    cp $1 $currentAddr
}

touch mylog.log
echo Hello, $USER!
    echo Enter for action!
    echo "cop <filename>                                   copy file"
    echo "del <filename>                                   delite file"
    echo "cpto <directory> <filename>                      copy file to directory"
    echo "stop                                             stop script"
    echo "write song <filename>                            write text of songs"
    echo "get                                              to get file URL from internet"
    echo /home/thinkpad/IdeaProjects/music


while [ 1 ]; do
    read action
    if [[ "$action" == *"cop"* ]]; then
    a=`echo $action | awk '{print $2}'`
    echo $a
    copyfile $a

    elif [[ "$action" == *"del"* ]]; then
    a=`echo $action | awk '{print $2}'`
    echo $a
    delfile ${a}

    elif [[ "$action" == *"write song"* ]]; then
    a=`echo $action | awk '{print $3}'`
    echo $a
    writeSong $a

    elif [[ "$action" == *"cpto"* ]]; then
    a=`echo $action | awk '{print $2}'`
    b=`awk`
    cpto $a $b

    elif [[ "$action" == *"get"* ]]; then
    a=`echo $action | awk '{print $2}'`
    getByUrl $a
    fi
done
