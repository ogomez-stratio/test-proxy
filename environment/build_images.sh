#!/usr/bin/env bash
echo "**********************************************"
echo "SANITAS Environment Images: Building!"
echo "Profile: " $SCD_PROFILES_ACTIVE
echo "**********************************************"

## Default value SCD_PROFILES_ACTIVE = dev
if [ -z "$SCD_PROFILES_ACTIVE" ]
then
  export SCD_PROFILES_ACTIVE="dev"
fi


CURRENT_DIR=$PWD


# SCD ###################
docker build -t scd-proxy ..


echo "**********************************************"
echo "SANITAS Environment Images are build succesfully!"
echo "Profile: "  $SCD_PROFILES_ACTIVE
echo "**********************************************"
exit 0
