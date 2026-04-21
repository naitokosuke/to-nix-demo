{ config, pkgs, ... }:

{
  home.username = "nix-demo";
  home.homeDirectory = "/Users/nix-demo";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    ripgrep
    mise
    rustup
  ];

  programs.home-manager.enable = true;
}
