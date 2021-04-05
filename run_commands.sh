#!/bin/bash

# Function to show user intended usage of bash script.
function usage {
  printf "USAGE: ${0} <server-list-file> <commands-file> [DEBUG]" 
}

# Parse mandatory commands
if [[ ${#} -lt 2 ]]; then
  usage;
  exit 1;
fi

# Read servers into array
IFS=$'\n' read -rd '' -a SERVERS <<<$(cat ${1})

# Read commands into array
IFS=$'\n' read -rd '' -a COMMANDS <<<$(cat ${2})

# Set default for optional argument.
DEBUG=0

# Parse optional Debug option
if [[ ${#} -eq 3 ]]; then
  DEBUG=${3}
else
  if [[ ${#} -gt 3 ]]; then
    usage;
    exit 1;
  fi
fi

if [[ $DEBUG -gt 0 ]]; then
  printf "The following commands:\n ${COMMANDS} \n will be execute on these servers: \n ${SERVER_LIST}\n"
fi

# Init connection.
eval "${SERVERS[0]} \"echo connection secured.\"" > /dev/null 2>&1

# Exectute actual commands on all servers.
for (( i=0; i<${#SERVERS[@]}; i++ )); do
  SERVER=${SERVERS[$i]}

  if [[ $DEBUG -gt 0 ]]; then
    printf "Starting to execute on ${SERVER}\n"
  fi
  
  for (( j=0; j<${#COMMANDS[@]}; j++ )); do
    COMMAND=${COMMANDS[$j]}
    eval "${SERVER} \"${COMMAND}\"" > /dev/null 2>&1
    if [[ $DEBUG -gt 0 ]]; then
     echo "The following command was executed: ${SERVER} \"${COMMAND}\""
    fi
  done
  
  if [[ $DEBUG -gt 0 ]]; then
    printf "Finished execution on ${SERVER}\n"
  fi
done 

exit
