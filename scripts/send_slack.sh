#!/bin/bash
set -e
usage() {
  echo "usage: ${0##*/} -u <SLACK_URL> -t <TEXT> -w <GITHUB_WOFKFLOW>"
  exit 1
}
send_slack() {
echo "Sending msg to slack"
curl -k -X POST -H 'Content-type: application/json' --data "{ \"type\":\"mrkdwn\", \"text\": \"${text}\" }" "${slack_url}"
}
while getopts ":u:t:c:e:w:" opt; do

 case $opt in
   u) slack_url="$OPTARG"
   ;;
   t) text="$OPTARG"
   ;;
   w) workflow="$OPTARG"
   ;;
   \?) echo "Invalid option -$OPTARG" >&2 && usage
   ;;
  esac
done

if [ -z "$slack_url" ] || [ -z "$text" ]
then
usage
fi
[ -z "${workflow}" ] && workflow="TBD"
env
send_slack

