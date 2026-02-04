{ ... }:

{
  # Hardware-specific configuration
  # Customize based on your actual hardware
  
  # Boot configuration
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" ];
  
  # File systems - customize for your setup
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };
  
  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
