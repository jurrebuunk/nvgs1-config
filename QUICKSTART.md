# Quick Start Commands

## Build and Deploy

```bash
# Update flake lock file
nix flake update

# Build the configuration (dry run)
nix flake show

# Switch to the new configuration
sudo nixos-rebuild switch --flake ".#nvgs1"

# Or just build without switching
sudo nixos-rebuild build --flake ".#nvgs1"
```

## Verify Installation

```bash
# Check GPU is detected
lspci | grep NVIDIA

# Test NVIDIA drivers
nvidia-smi

# Check Ollama service
systemctl status ollama

# Check Ollama is listening
sudo ss -tlnp | grep 11434

# Test Ollama API
curl http://localhost:11434/api/tags
```

## Pull and Run Models

```bash
# Pull a model
curl -X POST http://localhost:11434/api/pull -d '{"name": "mistral"}'

# List available models
curl http://localhost:11434/api/tags | jq

# Generate text with a model
curl -X POST http://localhost:11434/api/generate \
  -d '{
    "model": "mistral",
    "prompt": "Hello, how are you?",
    "stream": false
  }' | jq
```

## Monitoring

```bash
# Watch Ollama logs
sudo journalctl -u ollama -f

# Watch GPU usage
nvidia-smi dmon

# Check Ollama process
ps aux | grep ollama
```

## Network Configuration

If you want to restrict access, edit `configuration.nix`:

```nix
# Change from "0.0.0.0" to specific IP
services.ollama.host = "192.168.1.100";

# Or keep localhost only
services.ollama.host = "127.0.0.1";
```

Then rebuild with `sudo nixos-rebuild switch --flake ".#nvgs1"`
