{ config, pkgs, ... }:

{
  # System configuration
  system.stateVersion = "24.05";

  # Allow unfree packages (NVIDIA drivers)
  nixpkgs.config.allowUnfree = true;

  # Enable NVIDIA drivers for RTX 4060
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Enable NVIDIA support
    modesetting.enable = true;
    
    # Use open-source drivers (recommended for RTX 40 series)
    open = true;
    
    # GPU power management
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  # CUDA support for Ollama
  environment.variables = {
    CUDA_PATH = "${pkgs.cuda}";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    ollama
  ];

  # Hardware acceleration for video
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Ollama service configuration
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    
    # Bind to all interfaces on port 11434
    host = "0.0.0.0";
    port = 11434;
    
    # Optional: Environment variables
    environmentVariables = {
      OLLAMA_MODELS = "/var/lib/ollama/models";
      CUDA_VISIBLE_DEVICES = "0";
    };
  };

  # Allow Ollama to be accessed from network
  networking.firewall.allowedTCPPorts = [ 11434 ];

  # Enable necessary services
  services.openssh.enable = true;

  # Bootloader (adjust based on your system)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.useDHCP = true;

  # Locale and timezone
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
}
