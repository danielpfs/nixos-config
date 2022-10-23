{ pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.systemPackages = with pkgs; [
    # extensions
    gnomeExtensions.vitals
    gnomeExtensions.caffeine
    gnomeExtensions.gsconnect
    gnomeExtensions.x11-gestures
    gnomeExtensions.no-titlebar-when-maximized
    gnomeExtensions.gtk-title-bar
    gnomeExtensions.clipboard-history
    gnomeExtensions.tray-icons-reloaded

    # Personal
    gnome.gnome-terminal
    gnome.gnome-tweaks
    gnome.dconf-editor
  ];
}
