{ pkgs, ... }:
let inherit (builtins) readFile;
in
{
  imports = [ ];

  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.package =
    pkgs.pulseaudio.override { jackaudioSupport = true; };

  sound.enable = true;

  services.jack = {
    jackd.enable = false;
    # support ALSA only programs via ALSA JACK PCM plugin
    alsa.enable = false;
    # support ALSA only programs via loopback device (supports programs like Steam)
    loopback = {
      enable = true;
      # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
      #dmixConfig = ''
      #  period_size 2048
      #'';
    };
  };

  environment.systemPackages = with pkgs; [
    ingen
    cadence
    carla
    zam-plugins
    pavucontrol
    vmpk
    noise-repellent
    x42-plugins
    ladspaPlugins
    pmidi
    patchage
    giada
    lsp-plugins
    qjackctl
    tartube
    infamousPlugins
    sooperlooper
    calf
  ];

}
