FROM python:3.13-slim

WORKDIR /app

# Install dependencies
RUN pip install --no-cache-dir pip-system-certs uv

# Copy source code
COPY mcp_clickhouse/ /app/mcp_clickhouse/
COPY pyproject.toml README.md /app/

# Install the package
RUN uv pip install --no-cache-dir -e .

# Run the MCP server
CMD ["python", "-m", "mcp_clickhouse.main"]
