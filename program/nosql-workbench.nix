{ pkgs, ... }:

let
  appimagePackage = (import ../util/appimage.nix { inherit pkgs; }).appimagePackage;
in
{
  nixpkgs.overlays = [
    (self: super: {
      nosql-workbench = appimagePackage {
        binName = "nosql-workbench";
        version = "3.3.0";
        url = "https://s3.amazonaws.com/nosql-workbench/NoSQL%20Workbench-linux-x86_64-3.3.0.AppImage";
        sha256 = "d790b84758141108e410d76511ea7a97cf3e41c0b1f0b6073366c12a9a0f7228";
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    nosql-workbench
  ];
}
