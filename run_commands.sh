#!/bin/bash

# Function to show user intended usage of bash script.
function usage {
  echo "USAGE: ${0} <server-list-file> <commands-file>" 
}

if [[ ${#} -ne 2 ]]; then
  usage
fi

SERVER_LIST = $(cat ${1})
COMMANDS_FILE = $(cat ${2})

echo $SERVER_LIST

exit
