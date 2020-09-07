{ lib, ... }: {
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  networking.nameservers =
    [ "0.0.0.0" "1.1.1.1#one.one.one.one" ];

  networking.wireless.iwd.enable = true;
}
