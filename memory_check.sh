#!/bin/bash
#EBN04302018

###declared mail variables
subject="Memory check - Critical"
from="edmundnavarrojr@gmail.com"
to="edmundnavarrojr@ymail.com"
also_to="edmundnavarrojr@ymail.com"

used=$(free -mt | grep Mem: | awk '{print $3}')
totalmem=$(free -mt | grep Mem: | awk '{print $2}')
usedmem=$(free -mt | grep Mem: | awk '{print $3}')
normal=$(free -mt | grep Mem:)
topProc="/tmp/top_proccesses_consuming_memory.txt"
val1="pid,ppid,cmd,%mem,%cpu"
val2="/tmp/top_proccesses_consuming_memory.txt"
critical="Warning, server memory is CRITICALLY low! Please Check!!! | Total Memory: $totalmem MB | Used Memory: $usedmem MB"
warning="Warning, server memory is running low! Please Check!!! | Total Memory: $free MB"
DATE=`date '+%Y%m%d %H:%M:%S'`

###Define help function
function help(){
    echo "mem_check - memusage";
    echo "Usage example:";
    echo "mem-check (-c|--critical) char (-w|--warning) char (-e|--email) char";
    echo "Options:";
    echo "-c or --critical char: Threshold. Required.";
    echo "-w or --warning char: Threshold. Required.";
    echo "-e or --email char: Email. Required.";
    exit 1;
}
 
###Declare vars. Flags initalizing to 0.
 
###Execute getopt
ARGS=$(getopt -o "c:w:e:" -l "critical:,warning:,email:" -n "mem_check" -- "$@");
 
###Bad arguments
if [ $? -ne 0 ];
then
    help;
fi
 
eval set -- "$ARGS";
 
while true; do
    case "$1" in
        -c|--critical)
            shift;
                    if [ -n "$1" ]; 
                    then
                        critical="$1";
                        shift;
                    fi
            ;;
        -w|--warning)
            shift;
                    if [ -n "$1" ]; 
                    then
                        warning="$1";
                        shift;
                    fi
            ;;
        -e|--email)
            shift;
                    if [ -n "$1" ]; 
                    then
                        email="$1";
                        shift;
                    fi
            ;;
 
        --)
            shift;
            break;
            ;;
    esac
done
 
###Check required arguments
if [ -z "$critical" ]
then
    echo "critical is required";
    help;
fi
 
###Iterate over rest arguments called $arg
for arg in "$@"
do
    # Your code here (remove example below)
    echo $arg
 
done
if [ -z "$warning" ]
then
    echo "warning is required";
    help;
fi
 
###Iterate over rest arguments called $arg
for arg in "$@"
do
    # Your code here (remove example below)
    echo $arg
 
done
if [ -z "$email" ]
then
    echo "email is required";
    help;
fi
 
###Iterate over rest arguments called $arg
for arg in "$@"
do
    # Your code here (remove example below)
    echo $arg
 
done

if [[ "$used" -gt 921 || "$used" -eq 1024 ]]; then ###90% or 100% of 1024
        ps -eo $val1 --sort=-%mem | head >$val2
	file=$topProc
	echo Warning, server memory is CRITICALLY low!!! Email Notification Generated! Please Check!!!
	echo $critical | mailx -a "$file" -s "$DATE $subject" -r "$from" -c "$to" "$also_to"
	echo "Total Memory: $totalmem MB"
	echo "Used Memory: $usedmem MB"
	exit 2


elif [[ "$free" -gt 614 || "$free" -eq 614 ]]; then ###60% of 1024MB
        echo Warning, server memory is running low!!! Please Check!!!
	echo $warning 
	echo "Total Memory: $totalmem MB"
	echo "Used Memory: $usedmem MB"
	exit 1

else
	echo OK!!! Memory is within threshold. Relax!!!
	echo""
	echo $normal
        echo "Total Memory: $totalmem MB"
        echo "Used Memory: $usedmem MB"
	exit 0
fi
