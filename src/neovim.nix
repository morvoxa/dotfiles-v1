{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    neovim
    gcc
    tree-sitter
    nixfmt
    stylua
    shfmt
  ];
}
