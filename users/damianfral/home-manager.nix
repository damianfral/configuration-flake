{ pkgs, ... }:

# let reason-language-server = (import "${builtins.fetchTarball https://github.com/jmackie/reasonml.nix/archive/master.tar.gz}" {})

{
  home.stateVersion = "20.09";
  home.packages = with pkgs; [
    abduco
    atool
    cloc
    curl
    git-hub
    dconf
    jack2Full
    pulseaudioFull
    gnumake
    haskellPackages.wai-app-static
    haskellPackages.xmobar
    htop
    httpie
    flameshot # Takes screenshots
    mosh
    nixFlakes
    nodejs
    trash-cli
    up
    vis
    wget
    yarn
    kubernetes
    exa

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

    niv
    nixops
    cachix

  ];

  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    font = {
      name = "Anonymice Nerd Font 10";
      package = pkgs.nerdfonts.override { fonts = [ "AnonymousPro" ]; };
    };
    settings = {

      cursor               = "#d8dee9";
      foreground           = "#d8dee9";
      background           = "#0e1420";
      selection_foreground = "#2e3440";
      selection_background = "#d8dee9";

      color0  = "#3b4252";
      color1  = "#bf616a";
      color2  = "#536e4c";
      color3  = "#ebcb8b";
      color4  = "#81a1c1";
      color5  = "#b48ead";
      color6  = "#88c0d0";
      color7  = "#e5e9f0";
      color8  = "#4c566a";
      color9  = "#bf616a";
      color10 = "#a3be8c";
      color11 = "#ebcb8b";
      color12 = "#81a1c1";
      color13 = "#b48ead";
      color14 = "#8fbcbb";
      color15 = "#eceff4";
    };
  };

  home.sessionVariables = {
    EDITOR = "vi";
    TERM = "xterm-256color";
  };

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    env.TERM = "xterm-256color";
    env.EDITOR = "vi";

    window.dimensions.columns = 80;
    window.dimensions.lines = 24;
    dpi = {
      x = 96;
      y = 96;
    };

    font.family = "Anonymice Nerd Font";
    font.size = 10;

    # Colors (Gotham)
    colors = {
      # Default colors
      primary = {
        background = "0x0a0f14";
        foreground = "0x98d1ce";
      };

      # Normal colors
      normal = {
        black = "0x0a0f14";
        red = "0xc33027";
        green = "0x26a98b";
        yellow = "0xedb54b";
        blue = "0x195465";
        magenta = "0x4e5165";
        cyan = "0x33859d";
        white = "0x98d1ce";
      };

      # Bright colors
      bright = {
        black = "0x10151b";
        red = "0xd26939";
        green = "0x48af7d";
        yellow = "0x245361";
        blue = "0x396788";
        magenta = "0x888ba5";
        cyan = "0x599caa";
        white = "0xd3ebe9";
      };
    };

    mouse.hide_when_typing = true;
    live_config_reload = true;
    draw_bold_text_with_bright_colors = true;
  };

  programs.fish.enable = true;
  programs.fish.shellAliases = {
    today = "date '+%Y/%m/%d'";
    ls = "exa";
  };

  programs.direnv.enable = true;
  programs.direnv.enableFishIntegration = true;

  programs.bat.enable = true;
  # programs.broot.enable = true;
  programs.jq.enable = true;
  programs.lesspipe.enable = true;
  programs.skim.enable = true;
  programs.starship.enable = true;

  # programs.firefox.enable = true;
  programs.mpv.enable = true;
  programs.mpv.config = {
    profile = "gpu-hq";
    force-window = "yes";
    ytdl-format = "bestvideo+worstaudio";
  };
  # programs.obs-studio.enable = true;

  programs.git.enable = true;
  programs.git.aliases = {
    pr = "!git push -u && hub pull-request $@ && hub pr show && true";
    co = "!git fetch && git checkout $@ && true";
    st = "!git status && true";
    ri = "!git rebase -i $@";

  };
  programs.git.userName = "damianfral";
  programs.git.userEmail = "huevofritopamojarpan@gmail.com";
  programs.git.extraConfig = ''
    [diff "sopsdiffer"]
      textconv = sops -d
  '';

  programs.gpg.enable = true;

  programs.neovim.enable = true;
  programs.neovim.withPython = true;
  programs.neovim.withPython3 = true;
  programs.neovim.withNodeJs = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.extraConfig = builtins.readFile ./init.vim;
  programs.neovim.plugins = with pkgs.vimPlugins;

    [
      # Code editing tools
      vim-easy-align
      deoplete-nvim
      vim-expand-region
      vim-multiple-cursors
      commentary
      vim-surround

      ctrlp
      open-browser-vim
      open-browser-github-vim
      vim-github-dashboard
      lightline-vim
      vim-gitgutter
      vim-startify

      vimwiki
      # vimwiki-markdown

      # Haskell stuff
      vim-hindent
      hlint-refactor-vim
      vim-stylishask
      coc-nvim
      haskell-vim

      # Other languages tools
      vim-coffee-script
      vim-nix
      vim-javascript

      # vim-reason-plus
      (pkgs.vimUtils.buildVimPlugin {
        name = "vim-reason-plus";
        src = pkgs.fetchFromGitHub {
          owner = "reasonml-editor";
          repo = "vim-reason-plus";
          rev = "c11a2940f8f3e3915e472c366fe460b0fe008bac";
          sha256 = "1vx7cwxzj6f12qcwcwa040adqk9cyzjd9f3ix26hnw2dw6r9cdr4";
        };
      })

      # vim-reason-plus
      (pkgs.vimUtils.buildVimPlugin {
        name = "vim-trailing-whitespace";
        src = pkgs.fetchFromGitHub {
          owner = "bronson";
          repo = "vim-trailing-whitespace";
          rev = "610ca1a97c8dc85cdeb38635e5a4703317c4b94d";
          sha256 = "1bh15yw2aysvpn2ndnc0s6jzc0y93x6q1blc5pph67rdix5bm7gy";
        };
      })
      # Themes
      vim-one
    ];

  programs.ssh.enable = true;
  programs.ssh.compression = true;
  programs.ssh.forwardAgent = true;
  programs.ssh.controlMaster = "auto";
  programs.ssh.controlPersist = "1h";
  programs.ssh.serverAliveInterval = 60;
  programs.ssh.extraConfig = ''
    BatchMode no
    AddKeysToAgent yes
    ServerAliveCountMax 10
    EscapeChar none
    IdentitiesOnly yes
  '';
  programs.ssh.matchBlocks = import ./ssh-hosts.nix;

  xdg.enable = true;

  services.lorri.enable = true;

  services.gpg-agent.enable = true;
  services.gpg-agent.enableScDaemon = true;
  services.gpg-agent.enableSshSupport = true;
  services.gpg-agent.defaultCacheTtl = 3600;

  services.redshift.enable = true;
  services.redshift.latitude = "42.28185";
  services.redshift.longitude = "-8.60917";
  services.redshift.brightness.day = "1";
  services.redshift.temperature.day = 6500;
  services.redshift.brightness.night = "0.8";
  services.redshift.temperature.night = 5200;

  # services.keybase.enable = true;
  # services.kbfs.enable = true;
  services.xsuspender.enable = false;
  services.dunst.enable = true;
  services.dunst.settings = {
    global = {

      font = "Anonymice Nerd Font 11";
      allow_markup = true;
      plain_text = false;
      format = "<b>%s</b>\\n%b";
      stack_duplicates = true;
      geometry = "300x50-15+49";
      follow = "mouse";
      separator_height = 2;
      padding = 6;
      horizontal_padding = 6;
      separator_color = "frame";

    };

    shortcuts = {
      close = "ctrl+space";

      close_all = "ctrl+shift+space";

      # Redisplay last message(s).
      # On the US keyboard layout "grave" is normally above TAB and left
      # of "1".
      history = "ctrl+grave";

      # Context menu.
      context = "ctrl+shift+period";

    };

    frame = {

      width = 3;
      color = "#002B36";
    };

    urgency_low = {
      frame_color = "#A3BE8C";
      foreground = "#D8DEE9";
      background = "#2E3440";
      timeout = 4;
    };

    urgency_normal = {
      frame_color = "#5E81AC";
      foreground = "#D8DEE9";
      background = "#4C566A";
      timeout = 6;
    };

    urgency_critical = {
      frame_color = "#D08770";
      foreground = "#ECEFF4";
      background = "#BF616A";
      timeout = 8;
    };
  };

  xsession.enable = true;
  xsession.windowManager.xmonad.enable = true;
  xsession.windowManager.xmonad.enableContribAndExtras = true;
  xsession.windowManager.xmonad.config =
    ../../profiles/graphical/xmonad/_xmonad.hs;

  home.file.xmobar = {
    source = ./xmobarrc;
    target = ".xmobarrc";
  };

  #home.file.neovim = {
  #  source = ./init.vim;
  #  target = ".config/nvim/init.vim";
  #};

  home.sessionVariables = {
    DSSI_PATH =
      "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
    LADSPA_PATH =
      "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
    LV2_PATH =
      "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2";
    LXVST_PATH =
      "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst";
    VST_PATH =
      "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst";
  };

}
