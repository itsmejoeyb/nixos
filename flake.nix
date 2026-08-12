{
  description = "Joey's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fetch3d.url = "github:areofyl/fetch";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      dms,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };

      chatgpt = import ./chatgpt.nix {
        inherit pkgs;
      };
    in
    {
      packages.${system}.chatgpt = chatgpt;

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs chatgpt; };
        inherit system;

        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };

            home-manager.users.joey = {
              imports = [
                ./home.nix

                dms.homeModules.dank-material-shell
              ];
            };
          }
        ];
      };
    };
}
