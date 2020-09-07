# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
with lib;
let cfg = config.services."pi-hole";
in {

  options.services."pi-hole" = {

    enable = mkOption {
      type        = types.bool;
      default     = false;
      description = ''
        Run pi-hole docker image as a systemwide daemon.
      '';
    };

    dns = mkOption {
      type        = types.str;
      default     = "1.1.1.1";
      description = ''
        Run pi-hole docker image as a systemwide daemon.
      '';
    };

  };

  config = mkIf cfg.enable {

    virtualisation.docker.enable = true;

    systemd.services."pi-hole" =

      let
        stateDir = "/var/lib/pihole/";
        serverIP = "127.0.0.1";
        script   = pkgs.writeScript "pi-hole-in-docker" ''
          #!${pkgs.bash}/bin/bash
          docker run --rm -t \
          --name pihole \
          -p ${serverIP}:53:53/tcp -p ${serverIP}:53:53/udp \
          -p 30080:80 \
          -p 30443:443 \
          -v "${stateDir}/pihole/:/etc/pihole/" \
          -v "${stateDir}/dnsmasq.d/:/etc/dnsmasq.d/" \
          --cap-add=NET_ADMIN \
          --dns=127.0.0.1 --dns=${cfg.dns} \
          pihole/pihole:latest
        '';
      in {
        description   = "Starts pi-hole docker container";
        after         = [ "docker.service " ];
        wants         = [ "wants.service " ];
        wantedBy      = [ "default.target" ];
        path          = [ pkgs.docker ];
        serviceConfig = { ExecStart = script; };
      };
  };
}
