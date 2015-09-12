#!/bin/sh

set -e

WERCKER_APP_ID=${WERCKER_APP_ID:-""}
GITHUB_COMMIT_ID=${GITHUB_COMMIT_ID:-""}
WERCKER_TOKEN=${WERCKER_TOKEN:-""}

payload=$(cat <<EOF
{
  "applicationId" : "$WERCKER_APP_ID",
  "branch" : "master",
  "commit" : "$GITHUB_COMMIT_ID",
  "message" : "Triggered-by-trigger.bash."
}
EOF
)

echo $(curl -s -H "Content-Type: application/json" \
            -H  "Authorization: Bearer $WERCKER_TOKEN" \
            -X POST -d "$payload" https://app.wercker.com/api/v3/builds)
