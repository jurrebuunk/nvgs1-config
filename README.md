# NixOS Configuration - NVIDIA RTX 4060 + Ollama

This project contains a NixOS configuration for running Ollama with NVIDIA RTX 4060 GPU acceleration.

## Project Structure

```
nvgs1-config/
├── flake.nix              # Flake definition with inputs/outputs
├── configuration.nix      # Main NixOS system configuration
├── hardware.nix           # Hardware-specific configuration (optional)
└── README.md             # This file
```

## Features

- **NVIDIA RTX 4060 Support**: Configured with open-source drivers and CUDA support
- **Ollama Integration**: LLM inference server with GPU acceleration
- **Network Access**: Ollama runs on `0.0.0.0:11434` for network access
- **Firewall**: Port 11434 is allowed through the firewall

## Installation

### Prerequisites

- NixOS system (or NixOS installed alongside another distro)
- NVIDIA RTX 4060 GPU
- Flakes enabled in Nix configuration

### Steps

1. **Clone or place configuration in NixOS config directory:**
   ```bash
   # Option A: Use as system configuration
   sudo cp -r . /etc/nixos/
   ```

2. **Update flake lock file:**
   ```bash
   nix flake update
   ```

3. **Build and switch to new configuration:**
   ```bash
   sudo nixos-rebuild switch --flake ".#nvgs1"
   ```

4. **Verify Ollama is running:**
   ```bash
   systemctl status ollama
   ```

5. **Test Ollama:**
   ```bash
   curl http://localhost:11434/api/tags
   ```

## Configuration Details

### NVIDIA Driver Configuration

- Uses open-source NVIDIA drivers (recommended for RTX 40 series)
- CUDA support enabled for GPU acceleration
- Hardware acceleration enabled
- NVIDIA persistence daemon runs in the background

### Ollama Configuration

- **Host**: `0.0.0.0` (all interfaces)
- **Port**: `11434`
- **GPU**: CUDA acceleration enabled
- **Models Directory**: `/var/lib/ollama/models`

### Pulling Models

Once Ollama is running, pull models:

```bash
# Pull a model (e.g., Mistral)
curl -X POST http://localhost:11434/api/pull -d '{"name": "mistral"}'

# Or use ollama CLI if installed
ollama pull mistral
ollama pull neural-chat
ollama pull dolphin-mixtral
```

## Customization

Edit `configuration.nix` to:
- Change Ollama port: Modify `services.ollama.port`
- Add/remove system packages: Edit `environment.systemPackages`
- Adjust GPU settings: Modify `hardware.nvidia` section
- Change model directory: Update `OLLAMA_MODELS` environment variable

## Troubleshooting

### Check GPU is recognized:
```bash
lspci | grep NVIDIA
nvidia-smi
```

### Check Ollama logs:
```bash
sudo journalctl -u ollama -f
```

### Verify network binding:
```bash
sudo ss -tlnp | grep 11434
```

## References

- [NixOS Manual - NVIDIA](https://nixos.org/manual/nixos/stable/#sec-gpu-accel-nvidia)
- [Ollama Documentation](https://github.com/ollama/ollama)
- [NixOS Flakes](https://nixos.wiki/wiki/Flakes)
