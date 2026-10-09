{ config, pkgs, ... }:

{
  home.username = "mor";
  home.homeDirectory = "/home/mor";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    neovim
    tree-sitter
    nixfmt
    stylua
    shfmt
    kdlfmt
    taplo
    gcc
  ];
  programs.devenv.enable = true;
  programs.opencode.enable = true;
  programs.home-manager.enable = true;
}
