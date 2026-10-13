
#!/bin/sh
set -eu

echo "Checking Ollama installation..."
command -v ollama || {
  echo "ERROR: Ollama executable not found in PATH"
  echo "PATH=$PATH"
  ls -la /usr/bin/ollama /bin/ollama /usr/local/bin/ollama 2>/dev/null || true
  exit 1
}

ollama serve &
OLLAMA_PID=$!

until ollama list >/dev/null 2>&1; do
  sleep 2
done

ollama pull "${OLLAMA_MODEL:-llama3.2:latest}"

wait "$OLLAMA_PID"
