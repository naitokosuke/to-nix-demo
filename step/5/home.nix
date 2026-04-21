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

  programs.git.enable = true;
  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    initContent = ''
      export PATH="$HOME/.vite-plus/current/bin:$PATH"
      eval "$(mise activate zsh)"
    '';
  };

  programs.home-manager.enable = true;
}
