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
inputs='{"ref": "main", "inputs": {"text": "'$text'"}}'

echo "Executing GitHub Action"
api_url=https://api.github.com/repos/parjun8840/gha01/actions/workflows/$workflow_id/dispatches
curl -k -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $PERSONAL_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    $api_url \
    -d "$inputs" 

