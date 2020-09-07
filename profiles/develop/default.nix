{ pkgs, ... }: {
  imports = [ ];

  virtualisation.docker.enable = true;
  environment.shellAliases = { v = "$EDITOR"; };
  environment.systemPackages = with pkgs; [

    awscli
    cfdyndns
    circleci-cli
    google-cloud-sdk
    sops
    vultr

    docker-compose
    dvtm
    file
    gnupg
    jq
    loc
    mosh
    ncdu
    pass
    ripgrep
    tokei
    tree
    wget

    gitAndTools.git-hub
    gitAndTools.git-open
    gitAndTools.hub
    git-crypt
    tig

    mongodb
    postgresql
    sqlite

    niv
    nixops
    cachix

  ];

  documentation.dev.enable = false;
  programs.thefuck.enable = true;
  programs.mtr.enable = true;
}
