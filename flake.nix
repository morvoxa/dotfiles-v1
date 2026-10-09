{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.zst";
  };

  outputs = inputs: {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ./src/configuration.nix
        ./src/cosmic.nix
        ./src/neovim.nix
      ];
    };
  };
}
