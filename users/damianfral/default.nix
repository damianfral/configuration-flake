{ config, pkgs, options, ... }: {

  imports =
    [
      ../../profiles/graphical
      ../../profiles/develop
      ../../profiles/laptop
      ../../profiles/audio
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.damianfral = {
    description = "damianfral";
    isNormalUser = true;
    uid = 1000;
    initialPassword = "1234";
    createHome = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "audio"
      "video"
      "storage"
      "lp"
      "jackaudio"
      "jackuser"
      "libvirtd"
    ];
    openssh.authorizedKeys.keys = [''
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjmdM4F5IToomdBzehHNDB9V9DwrS2KBU77e68xR2DT38ZJCunRSddYW8etA+VSZxTuvSq1VINbzHGdqe3GqIdaqjyg8xjrNhjgTigPcUuv0E0JmcniXjn21Mqtm11o6XuHFK0Ag
      aIXMJNHE966OC196uQ2Zipd0c/CRFCmMhNpjY6J4VHH+k5OdfxidrXGZkzCmDSgmcJe0qHXHyf16+Bw/xq8IV1tvhOJOEPf5RhiMVuEztTN7UnFS96MjCtdz/AOcpKu1kisFsGgkiyTqZQ3BJgyI7g6t9TAm3PS81N0tvdTCQ971aH0yblIS0wGrlm+j5Aaw4md7y6ROaSBU05 damian
      fral@nixos''];
  };

  users.defaultUserShell = "${pkgs.fish}/bin/fish";

  home-manager.users.damianfral = import ./home-manager.nix;
  home-manager.useUserPackages = true;

}
