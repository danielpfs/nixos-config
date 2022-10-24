{
  description = "NixOS by danielpfs";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs }:
  let
    nixosSystem = nixpkgs.lib.nixosSystem;
  in
  {
    nixosConfigurations = {
      os = nixosSystem {
        # specialArgs = { inherit inputs user location; };
        modules = [
          ./system
        ];
      };
    };
  };
}
