{ pkgs, ... }: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  users.users.mor = {
    extraGroups = [
      "podman"
    ];
  };

  environment.systemPackages = with pkgs; [
    distrobox
  ];

}
