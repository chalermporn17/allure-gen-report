# Generate Allure Report GitHub Action

## Overview

This GitHub Action simplifies the generation of [Allure](https://docs.qameta.io/allure/) test reports within your GitHub Actions workflow.

---

## Purpose of This Action

- **Automates Allure Setup**: Installs Allure CommandLine and its dependencies (Java) within the Docker environment, eliminating the need for manual installation.
- **Manages Report History**: Properly handles the history data to enable trend charts and historical data in Allure reports.
- **Configures `executor.json`**: Generates the `executor.json` file with required parameters to enhance the report with build and environment information.
- **Simplifies Report Generation**: Provides an easy-to-use action to generate Allure reports without complex setup.

---

## Action Parameters

### Inputs

The action accepts several inputs to customize the report generation process:

| **Input Name**                | **Description**                                                      | **Required** | **Default Value**                |
| ----------------------------- | -------------------------------------------------------------------- | ------------ | -------------------------------- |
| `report_name`                 | The name of the Allure report.                                       | Yes          | `allure-report`                  |
| `allure_result_path`          | Path to the directory containing Allure result files (`allure-results`). | Yes          |                                  |
| `allure_previous_report_path` | Path to the previous Allure report directory to copy history from.   | No           | `""` (empty string)              |
| `allure_output_report_path`   | Path where the generated Allure report should be saved.              | Yes          |                                  |
| `report_url`                  | Base URL where the Allure report will be hosted. Used for hyperlinks in the report. | No           | `""` (empty string)              |
| `github_server_url`           | GitHub server URL.                                                   | Yes          | `${{ github.server_url }}`       |
| `github_repository`           | GitHub repository in `owner/repo` format.                            | Yes          | `${{ github.repository }}`       |
| `github_run_id`               | GitHub Actions run ID.                                               | Yes          | `${{ github.run_id }}`           |
| `github_run_number`           | GitHub Actions run number.                                           | Yes          | `${{ github.run_number }}`       |

### Environment Variables

The action uses environment variables mapped from the inputs:

- `ALLURE_RESULT_PATH`: Path to the Allure results directory (`allure-results`).
- `ALLURE_PREVIOUS_REPORT_PATH`: Path to the previous Allure report (used for history).
- `ALLURE_OUTPUT_REPORT_PATH`: Path where the Allure report will be generated.
- `REPORT_NAME`: Name of the Allure report.
- `REPORT_URL`: URL where the report will be accessible.
- `GITHUB_SERVER_URL`: GitHub server URL.
- `GITHUB_REPOSITORY`: GitHub repository (`owner/repo`).
- `WORKFLOW_RUN_ID`: GitHub Actions run ID.
- `WORKFLOW_RUN_NUMBER`: GitHub Actions run number.

---

## How to Use This Action

### Step 1: Generate Allure Results in Your Tests

Ensure that your tests generate Allure result files in a directory (usually named `allure-results`). This is typically done by configuring your test runner (e.g., pytest, JUnit) to output results in the Allure format.

### Step 2: Add the Action to Your Workflow

Include the action in your GitHub Actions workflow YAML file.

#### Basic Example

```yaml
name: Run Tests and Generate Allure Report

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Java environment
        uses: actions/setup-java@v3
        with:
          java-version: '11'

      - name: Install dependencies
        run: |
          # Install any required dependencies here
          # For example, if using Python:
          # pip install -r requirements.txt

      - name: Run tests and generate Allure results
        run: |
          # Run your tests here
          # Ensure that Allure results are saved to the allure-results directory
          # For example:
          # pytest --alluredir=./allure-results

      - name: Generate Allure Report
        uses: chalermporn17/allure-gen-report@v0.1.0
        with:
          report_name: 'My Allure Report'
          allure_result_path: './allure-results'
          allure_output_report_path: './allure-report'
          report_url: 'https://your-domain.com/allure-report'
```

### Step 3: (Optional) Handle Report History

If you wish to maintain report history to enable features like trend graphs, you can configure the action to use the previous report's history.

#### Example with History

```yaml
      - name: Download previous Allure report
        uses: actions/download-artifact@v3
        with:
          name: allure-report
          path: ./previous-allure-report

      - name: Generate Allure Report with History
        uses: chalermporn17/allure-gen-report@v0.1.0
        with:
          report_name: 'My Allure Report'
          allure_result_path: './allure-results'
          allure_previous_report_path: './previous-allure-report'
          allure_output_report_path: './allure-report'
          report_url: 'https://your-domain.com/allure-report'
```

In this example:

- **Download previous Allure report**: Retrieves the previous report to extract the `history` folder.
- **Generate Allure Report with History**: Uses the action with `allure_previous_report_path` to include history.
- **Upload Allure Report**: Saves the report as an artifact for future use or hosting.

### Step 4: (Optional) Host or Deploy the Report

After generating the report, you can host it using various methods:
- **GitHub Pages**: Deploy the report to GitHub Pages.
- **Artifact Downloads**: Download the report artifact from the Actions run.
- **External Hosting**: Upload the report to an external server or cloud storage.
---

## Conclusion

By using this action, you can effortlessly generate Allure reports in your CI/CD pipeline without worrying about the complexities of setting up Allure, managing history, and configuring reports. This action automates the necessary steps, allowing you to focus on writing tests and improving code quality.