#!/bin/bash

set -e

if [ -z "$ATLASSIAN_API_TOKEN" ]; then
  echo "Error: ATLASSIAN_API_TOKEN environment variable is not set."
  exit 1
fi

cat > .cursor/mcp.json <<EOF
{
    "mcpServers": {
      "mcp-atlassian": {
        "command": "docker",
        "args": [
          "run",
          "-i",
          "--rm",
          "-e", "JIRA_URL",
          "-e", "JIRA_USERNAME",
          "-e", "JIRA_API_TOKEN",
          "-e", "JIRA_PROJECTS_FILTER",
          "ghcr.io/sooperset/mcp-atlassian:latest"
        ],
        "env": {
          "CONFLUENCE_API_TOKEN": "$ATLASSIAN_API_TOKEN",
          "JIRA_URL": "https://cognitedata.atlassian.net",
          "JIRA_USERNAME": "anders.hafreager@cognite.com",
          "JIRA_API_TOKEN": "$ATLASSIAN_API_TOKEN",
          "JIRA_PROJECTS_FILTER": "DOGE",
          "CONFLUENCE_SPACES_FILTER": "PD"
        }
      }
    }
  }
EOF

echo ".cursor/mcp.json generated successfully."
