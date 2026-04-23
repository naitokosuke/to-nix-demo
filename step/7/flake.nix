{
  description = "nix-demo darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin }: {
    darwinConfigurations."nix-demo" = nix-darwin.lib.darwinSystem {
      modules = [
        ({ pkgs, ... }: {
          system.stateVersion = 6;
          system.primaryUser = "nix-demo";
          nixpkgs.hostPlatform = "aarch64-darwin";
          nix.settings.experimental-features = [ "nix-command" "flakes" ];

          homebrew = {
            enable = true;
            onActivation.cleanup = "uninstall";
            casks = [ "ghostty" ];
          };
        })
      ];
    };
  };
}
