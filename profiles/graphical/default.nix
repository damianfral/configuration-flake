{ pkgs, ... }:
let inherit (builtins) readFile;
in
{
  imports = [ ./xmonad ./im ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  boot = {

    kernelPackages = pkgs.linuxPackages_latest;

    tmpOnTmpfs = true;

    kernel.sysctl."kernel.sysrq" = 1;

  };

  environment = {

    etc = {
      "xdg/gtk-3.0/settings.ini" = {
        text = ''
          [Settings]
          gtk-icon-theme-name=Papirus
          gtk-theme-name=Arc-Darker
          gtk-cursor-theme-name=Papirus
        '';
        mode = "444";
      };
    };

    sessionVariables = {
      # Theme settings
      QT_QPA_PLATFORMTHEME = "gtk2";

      GTK2_RC_FILES =
        let
          gtk = ''
            gtk-icon-theme-name="Papirus"
            gtk-cursor-theme-name="Arc"
          '';
        in
        [
          ("${pkgs.writeText "iconrc" "${gtk}"}")
          "${pkgs.arc-theme}/share/themes/Arc-Darker/gtk-2.0/gtkrc"
          "${pkgs.gnome3.gnome-themes-extra}/share/themes/Arc-Darker/gtk-2.0/gtkrc"
        ];
    };

    systemPackages = with pkgs; [
      arc-theme
      imagemagick
      papirus-icon-theme
      pulsemixer
      xsel
      ffmpeg-full
      mupdf
      dunst
    ];
  };

  services.xbanish.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Xmonad
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  # LightDM
  services.xserver.displayManager.defaultSession = "none+xmonad";
  services.xserver.displayManager.lightdm.enable = true;

}
