{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.kernelModules = [ "kvm-amd" "nvidia" "nvidia_modeset" "nvidia_uvm" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4838f0a8-d081-4b80-b80e-dfbdf58fe35d";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/91aafa78-6fda-4615-ad12-7272f63f14e8"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}