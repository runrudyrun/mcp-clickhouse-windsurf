# Running ClickHouse MCP Server in Docker for Windsurf

This guide explains how to set up the ClickHouse MCP server in Docker for use with Windsurf, eliminating the need to occupy a terminal.

## Prerequisites

- Docker and Docker Compose installed on your system
- Windsurf client installed
- ClickHouse credentials (host, port, username, password)

## Setup Instructions

### 1. Configure Environment Variables (Optional)

Create a `.env` file in the same directory as the `docker-compose.yml` file with your ClickHouse credentials:

```
CLICKHOUSE_HOST=your-clickhouse-host
CLICKHOUSE_PORT=your-clickhouse-port
CLICKHOUSE_USER=your-username
CLICKHOUSE_PASSWORD=your-password
CLICKHOUSE_SECURE=true
CLICKHOUSE_VERIFY=true
CLICKHOUSE_CONNECT_TIMEOUT=30
CLICKHOUSE_SEND_RECEIVE_TIMEOUT=30
CLICKHOUSE_DATABASE=your-database  # Optional
```

If you don't create a `.env` file, the Docker Compose file will use the ClickHouse SQL Playground by default.

### 2. Start the Docker Container

Run the following command to build and start the ClickHouse MCP server in a Docker container:

```bash
docker-compose up -d
```

This will build the Docker image if it doesn't exist and start the container in detached mode.

### 3. Configure Windsurf

Edit the Windsurf MCP configuration file located at `~/.codeium/windsurf/mcp_config.json`. If the file doesn't exist, create it with the following content:

```json
{
  "mcpServers": {
    "mcp-clickhouse": {
      "type": "http",
      "url": "http://localhost:8000",
      "env": {}
    }
  }
}
```

This configures Windsurf to use the containerized MCP server running on localhost port 8000.

### 4. Restart Windsurf

Restart Windsurf to apply the configuration changes.

## Maintenance Commands

- To view the logs: `docker-compose logs -f`
- To stop the container: `docker-compose down`
- To restart the container: `docker-compose restart`
- To update after code changes: `docker-compose up -d --build`

## Troubleshooting

If you encounter connection issues:

1. Make sure the Docker container is running: `docker ps | grep mcp-clickhouse`
2. Check the container logs: `docker-compose logs -f`
3. Ensure your ClickHouse credentials are correct in the `.env` file
4. Verify that port 8000 is not being used by another application

## Notes on Timestamps

When working with Amplitude integration, remember that all datetime fields in the API payload must be in Unix timestamp milliseconds format (milliseconds since epoch):

1. The main "time" field for events MUST be an integer in milliseconds since epoch
2. All date/time fields should use Unix milliseconds for consistent processing
3. String date formats (including ISO-8601) will not work with Amplitude's time picker and filtering features
4. Use standardized datetime conversion functions to ensure consistent formatting
