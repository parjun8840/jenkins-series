#!/bin/bash
set -e
usage() {
  echo "usage: ${0##*/} -u <SLACK_URL> -t <TEXT> -c <COLOR> -e <EMOJI> -w <GITHUB_WOFKFLOW>"
  exit 1
}
send_slack() {
echo "Inside Slack send function"
echo 'payload={"text": "'${text}'", "color": "'${color}'", "icon_emoji": "'${emoji}'"}'
echo "SLACK URL is: ${slack_url}"
#curl -X POST --data-urlencode 'payload={"text": "'${text}'", "color": "'${color}'", "icon_emoji": "'${emoji}'"}' "${slack_url}"
curl -X POST -H 'Content-type: application/json' --data '{"text": "'${text}'", "color": "'${color}'", "icon_emoji": "'${emoji}'"}' "${slack_url}"
}

while getopts ":u:t:c:e:w:" opt; do

 case $opt in
   u) slack_url="$OPTARG"
   ;;
   t) text="$OPTARG"
   ;;
   c) color="$OPTARG"
   ;;
   e) emoji="$OPTARG"
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

[ -z "${color}" ] && color="#00a3e0"
[ -z "${emoji}" ] && emoji=":tiger:"
[ -z "${workflow}" ] && workflow="TBD"

send_slack

