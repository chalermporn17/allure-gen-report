#! /bin/bash

if [ "$ALLURE_PREVIOUS_REPORT_PATH" != "" ]; then
   echo "Copying previous report from $ALLURE_PREVIOUS_REPORT_PATH to $INPUT_ALLURE_RESULT_PATH/history"
   cp -r "$ALLURE_PREVIOUS_REPORT_PATH/history" "$ALLURE_RESULT_PATH/history"
fi

echo '{"name":"GitHub Actions","type":"github","reportName":"'"$REPORT_NAME"'",' > executor.json
echo "\"url\":\"${REPORT_URL}\"," >> executor.json # ???
echo "\"reportUrl\":\"${REPORT_URL}\"," >> executor.json
echo "\"buildUrl\":\"${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${WORKFLOW_RUN_ID}\"," >> executor.json
echo "\"buildName\":\"GitHub Actions Run #${WORKFLOW_RUN_ID}\",\"buildOrder\":\"${WORKFLOW_RUN_NUMBER}\"}" >> executor.json

cat executor.json

mv executor.json $ALLURE_RESULT_PATH/executor.json
allure generate --clean $ALLURE_RESULT_PATH -o $ALLURE_OUTPUT_REPORT_PATH