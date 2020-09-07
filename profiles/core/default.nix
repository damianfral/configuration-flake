{ config, lib, pkgs, ... }:
let inherit (lib) fileContents;

in
  {

  nix.binaryCaches = [
    "https://feeld-nixcache.s3.amazonaws.com/"
    "https://cache.nixos.org/"
  ];

  nix.binaryCachePublicKeys = [
    "feeld-circleci:Rgj3MboxJuJerz4vLK8srQS4uJ41cesRwq1dF5SPXho="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];


  nix.package = pkgs.nixFlakes;

  nix.systemFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];

  imports = [ ../../local/locale.nix ];

  environment = {

    systemPackages = with pkgs; [
      atool # Work with compressed files
      binutils
      coreutils
      curl
      direnv
      dnsutils
      dosfstools
      fd
      git
      gnumake
      gotop
      gptfdisk
      haskellPackages.wai-app-static
      htop
      iputils
      jq
      moreutils
      ncdu # NCurses Disk Usage
      # duf
      nmap
      ripgrep
      utillinux
      linuxPackages.cpupower
      vis
      wget
      whois
      kitty
    ];

    # shellInit = ''
    #   export STARSHIP_CONFIG=${
    #     pkgs.writeText "starship.toml"
    #     (fileContents ./starship.toml)
    #   }
    # '';
  };

  nix = {

    autoOptimiseStore  = true;
    gc.automatic       = true;
    optimise.automatic = true;

    useSandbox = true;

    allowedUsers = [ "@wheel" ];
    trustedUsers = [ "root" "@wheel" ];

    extraOptions = ''
      experimental-features = nix-command flakes ca-references
      min-free = 536870912
    '';

  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      anonymousPro
      terminus_font
      inconsolata
      ubuntu_font_family
    ];
  };


  security = {
    hideProcessInformation = true;
    protectKernelImage = true;
  };

  users.mutableUsers = true;
  zramSwap.enable = true;
}
