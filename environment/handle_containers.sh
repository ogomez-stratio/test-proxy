#!/usr/bin/env bash

####################################
#          DANGER ZONE             #
# DONT MODIFY ANYTHING BEYOND THIS #
# LINE IF YOU ARE NOT SURE         #
####################################
if [ "$#" -lt 1 ]
then
  echo "Usage: $0 start/stop/reset/clean-all" >&2
  exit 1
fi

## Default value SCD_PROFILES_ACTIVE = develop
if [ -z "$SCD_PROFILES_ACTIVE" ]
then
  export SCD_PROFILES_ACTIVE="dev"
fi

MY_PATH="`dirname \"$0\"`" # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"

ENV_PHASE1="`( cd \"$MY_PATH\" && cd ../environment && pwd )`"

COMMAND=$1
if [ "$COMMAND" == "start" ]
then
  echo 'Starting SANITAS Environment...' $SCD_PROFILES_ACTIVE
  docker-compose -f docker-compose-scd.yml up -d
  if [[ "$SCD_PROFILES_ACTIVE" = *"dev"* ]]; then
      # updating /etc/hosts  (root needed)
      sudo $ENV_PHASE1/hosts_update.sh
   fi

elif [ "$COMMAND" == "stop" ]
then
    docker-compose -f docker-compose-scd.yml stop

elif [ "$COMMAND" == "reset" ]
then
  docker-compose -f docker-compose-scd.yml rm -f
  docker-compose -f docker-compose-scd.yml up -d
  if [[ "$SCD_PROFILES_ACTIVE" = *"dev"* ]]; then
    # updating /etc/hosts  (root needed)
    sudo $ENV_PHASE1/hosts_update.sh
  fi

elif [ "$COMMAND" == "clean-all" ]
then
  docker-compose -f docker-compose-scd.yml kill
  docker-compose -f docker-compose-scd.yml rm -f
else
  echo "Unknown option ${COMMAND}, usage: $0 start/stop/reset/clean-all" >&2
  exit 1
fi
