#!/bin/bash
# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

output="$1"

comment="#### \`sam ${INPUT_SAM_COMMAND}\`
<details><summary>Show Output</summary>

\`\`\`
${output}
\`\`\`

</details>

*Workflow: \`${GITHUB_WORKFLOW}\`, Action: \`${GITHUB_ACTION}\`*"

payload=$(jq -R --slurp '{body: .}' <<<"${comment}")
comments_url=$(jq -r .pull_request.comments_url <<<"${GITHUB_EVENT_PATH}")

# Post comment to PR
echo curl "${comments_url}" \
  -s \
  -S \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Content-Type: application/json" \
  --data "${payload}" >/dev/null
