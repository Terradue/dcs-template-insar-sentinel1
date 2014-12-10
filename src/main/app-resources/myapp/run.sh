#!/bin/bash
# source the ciop functions (e.g. ciop-log)
source ${ciop_job_include}
# define the exit codes
SUCCESS=0
ERR_MASTER=10
ERR_SLAVE=20
ERR_EXTRACT=30
ERR_ADORE=40
ERR_PUBLISH=50
# add a trap to exit gracefully
function cleanExit () {

  local retval=$?
  local msg=""

  case "$retval" in
    $SUCCESS) msg="Processing successfully concluded";;
    $ERR_MASTER) msg="Failed to retrieve the master product";;
    $ERR_SLAVE) msg="Failed to retrieve the slave product";;
    $ERR_EXTRACT) msg="Failed to retrieve the extract the vol and lea";;
    $ERR_ADORE) msg="Failed during ADORE execution";;
    $ERR_PUBLISH) msg="Failed results publish";;
    *) msg="Unknown error";;
  esac
  [ "$retval" != "0" ] && ciop-log "ERROR" "Error $retval - $msg, processing aborted" || ciop-log "INFO" "$msg"
  exit $retval
}

trap cleanExit EXIT

param1="`ciop-getparam param1`"

# loop through the pairs
while read pair
do
  masterref=`echo $pair | cut -d";" -f1`
  slaveref=`echo $pair | cut -d";" -f2`

  master=`echo $masterref | ciop-copy -U -O $TMPDIR`
  slave=`echo $slaveref | ciop-copy -U -O $TMPDIR`

  # invoke the app with the local staged data

done
