#!/bin/bash
# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

# Required inputs
if [ "${INPUT_SAM_COMMAND}" == "" ]; then
  echo "Input sam_subcommand cannot be empty"
  exit 1
fi

output=$(sam "${INPUT_SAM_COMMAND}")

if [ "$GITHUB_EVENT_NAME" == "pull_request" ] && [ "${INPUT_ACTIONS_COMMENT}" == "true" ]; then
  ./post_comment.sh "$output"
fi
