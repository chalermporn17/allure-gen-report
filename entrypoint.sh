#! /bin/bash
# For github action
echo '{"name":"GitHub Actions","type":"github","reportName":"'"$REPORT_NAME"'",' > executor.json
echo "\"url\":\"${REPORT_URL}\"," >> executor.json # ???
echo "\"reportUrl\":\"${REPORT_URL}\"," >> executor.json
echo "\"buildUrl\":\"${INPUT_GITHUB_SERVER_URL}/${{ github.repository }}/actions/runs/${{ github.run_id }}\"," >> executor.json
echo "\"buildName\":\"GitHub Actions Run #${{ github.run_id }}\",\"buildOrder\":\"${{ github.run_number }}\"}" >> executor.json

cat executor.json

mv executor.json $ALLURE_RESULT_PATH/executor.json
allure generate --clean $ALLURE_RESULT_PATH -o $ALLURE_OUTPUT_REPORT_PATH