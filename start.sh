
#!/bin/sh
set -eu

ollama serve &
OLLAMA_PID=$!

until ollama list >/dev/null 2>&1; do
  sleep 2
done

ollama pull "${OLLAMA_MODEL:-llama3.2:latest}"

wait "$OLLAMA_PID"
