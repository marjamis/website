#!/bin/bash -ex

# TEMP
GITHUB_TOKEN=38b40044fc5deafdcc530d621c1342482f4acd30

CURL_COMMAND='curl -X POST https://api.github.com/graphql'
RAW_OUTPUT_FILE="$(tempfile -s ".query.output")"
MINIMUM_PLUS_1_COUNT=20

function API_call() {
  if [ ! -v NEXT_PAGE ]; then
    api_output=$($CURL_COMMAND  -H "Authorization:bearer $GITHUB_TOKEN" -d @query)
  else
    newQuery=$(cat query | sed 's/first:100,/first:100, after:\\"'$NEXT_PAGE'\\", /' > query.temp)
    api_output=$($CURL_COMMAND  -H "Authorization:bearer $GITHUB_TOKEN" -d @query.temp)
    rm query.temp
  fi

  echo $api_output >> $RAW_OUTPUT_FILE
  if [ $(echo $api_output | jq -r ".data.repository.issues.pageInfo.hasNextPage") == "false" ] ; then
    echo null
    exit
  fi
  echo $api_output | jq -r ".data.repository.issues.edges[-1].cursor"
}

function paginateLoop() {
  while [ "$NEXT_PAGE" != "null" ]; do
    NEXT_PAGE=$(API_call $NEXT_PAGE)
  done
}

paginateLoop

# # Note: Need to name it thumbsUp for a key (no shortcut) to be able to move it up a level
# -s to  combine multiple pages in the file into an array, as referenced with the .[] part below and then all things are in the one array rather than the same operations being applied to each array/page of data in the file
jq -rs '[.[].data.repository.issues.edges[].node | {url, title, createdAt, thumbsUp: .reactions.thumbsUp}] | map(select(.thumbsUp >= '$MINIMUM_PLUS_1_COUNT')) | sort_by(.thumbsUp) | reverse | .[0:10]' $RAW_OUTPUT_FILE | tee analysis.json
echo ---
jq -rs '[.[].data.repository.issues.edges[].node | {url, title, createdAt, thumbsUp: .reactions.thumbsUp}] | map(select(.thumbsUp >= '$MINIMUM_PLUS_1_COUNT')) | sort_by(.thumbsUp) | reverse | .[0:10] | (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[]  | @csv' $RAW_OUTPUT_FILE | tee analysis.csv

rm $RAW_OUTPUT_FILE
