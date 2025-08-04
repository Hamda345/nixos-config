{
  description = "KooL's NixOS-Hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";  # alternative

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:aylur/ags/v1"; # aylur's ags v1
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ags, ... }:
    let
      system = "x86_64-linux";
      host = "nixos";
      username = "hamda";

      # Import nixpkgs with config
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      # Home Manager module for use in NixOS
      hmModule = home-manager.modules.home-manager;
    in
    {
      # NixOS configuration
      nixosConfigurations."${host}" = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit system inputs username host; };

        modules = [
          ./hosts/${host}/config.nix

          # Include Home Manager as a NixOS module
          hmModule

          # Configuration for Home Manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./hosts/${host}/home.nix;
          }
        ];
      };

      # Optional: Expose a standalone Home Manager configuration (for `home-manager switch --flake`)
      homeConfigurations."${username}@${host}" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        username = username;
        homeDirectory = "/home/${username}";
        configuration = import ./hosts/${host}/home.nix;
        extraSpecialArgs = { inherit system inputs username host; };
      };
    };
}
