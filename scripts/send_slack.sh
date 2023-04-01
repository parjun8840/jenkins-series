#!/bin/sh
set -e
usage() {
  echo "usage: ${0##*/} -u <SLACK_URL> -t <TEXT> -c <COLOR> -e <EMOJI> -w <GITHUB_WOFKFLOW>"
  exit 1
}
send_slack() {
echo "Inside Slack send function"
curl -X POST --data-urlencode 'payload={"text": "'${text}'", "color": "'${color}'", "icon_emoji": "'${emoji}'"}' "${slack_url}" > /dev/null 2>&1
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

[ -z "${color}" ] && icon="#00a3e0"
[ -z "${emoji}" ] && emoji=":tiger:"
[ -z "${workflow}" ] && workflow="TBD"

send_slack

