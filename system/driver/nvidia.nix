{ pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  # Enable nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    offload.enable = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # External display
  services.xserver.displayManager.sessionCommands = ''
    xrandr --setprovideroutputsource NVIDIA-G0 modesetting
    xrandr --auto
  '';

  hardware.nvidia.powerManagement.finegrained = true;

  environment.systemPackages = with pkgs; [
    nvidia-offload
  ];
}
