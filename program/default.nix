{ pkgs, ... }:

{
  imports = [
    ./nosql-workbench.nix
  ];

  environment.systemPackages = with pkgs; [
    # System
    libgtop
    lm_sensors
    pciutils
    xclip
    ventoy-bin

    # Personal
    (google-chrome.override {
      commandLineArgs = [
        "--enable-features=WebUIDarkMode --force-dark-mode"
      ];
    })
    firefox
    discord
    onlyoffice-bin
    inkscape
    gimp

    # Dev
    asdf-vm
    anydesk
    flameshot
    docker
    vscode
    git
    dbeaver
    slack
    kcachegrind
    graphviz
  ];

  # Enable Docker
  virtualisation.docker.enable = true;
}
