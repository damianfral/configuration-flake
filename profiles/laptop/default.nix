{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    acpi
    lm_sensors
    pciutils
    usbutils
  ];

  hardware.bluetooth.enable = true;

  # to enable brightness keys 'keys' value may need updating per device
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      {
        keys = [ 225 ];
        events = [ "key" ];
        command = "/run/current-system/sw/bin/light -A 5";
      }
      {
        keys = [ 224 ];
        events = [ "key" ];
        command = "/run/current-system/sw/bin/light -U 5";
      }
    ];
  };

  # better timesync for unstable internet connections
  services.chrony.enable = true;
  services.timesyncd.enable = false;

  # power management features
  services.tlp.enable = true;
}
