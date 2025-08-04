# hosts/nixos/home.nix
{ config, pkgs, username, host, inputs, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  # Use same NIXOS_OZONE_WL for Electron/Wayland apps
  xdg.configHome = ".config";
  xdg.dataHome = ".local/share";
  xdg.cacheHome = ".cache";

  # Enable home-manager
  programs.home-manager.enable = true;

  # Shell
  programs.zsh.enable = true;
  programs.bash.enable = false;

  # Environment variables
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
  };

  # User packages
  home.packages = with pkgs; [
    # Utilities
    neovim
    git
    eza
    lsd
    zoxide
    fzf
    starship
    fastfetch
    # Browsers & Apps
    firefox
    brave-bin
    # Dev
    nodejs
    python3
    pipewire
    # Media
    playerctl
    swaybg
    slurp
    grim
    wl-clipboard
    # AGS dependencies
    gsettings-desktop-schemas
    libnotify
  ];

  # Git config
  programs.git = {
    enable = true;
    userName = "Your Name";
    userEmail = "you@example.com";
  };

  # Starship prompt
  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
    format = ''
      $username$hostname$localip$shlvl$directory$vcsh$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$docker_context$package$cmake$dart$deno$dotnet$elixir$elm$erlang$golang$helm$java$javascript$lua$nim$nix_shell$nodejs$ocaml$perl$php$pulumi$python$rlang$red$ruby$rust$scala$swift$terraform$vagrant$zig$time$cmd_duration$line_break$jobs$battery$custom$fill$all
    '';
  };

  # AGS config (if using input.ags)
  home.file.".config/ags" = {
    source = ../assets/ags-config; # optional: if you have custom AGS config
    recursive = true;
  };

  # Optional: Copy entire dotfile dirs
  home.file = {
    # Hyprland config
    ".config/hypr" = {
      source = ../../../assets/configs/hypr;
      recursive = true;
      mode = "755";
    };
    # Wallust (dynamic color generation)
    ".config/wallust" = {
      source = ../../../assets/configs/wallust;
      recursive = true;
      mode = "755";
    };

    # wlogout (logout menu)
    ".config/wlogout" = {
      source = ../../../assets/configs/wlogout;
      recursive = true;
      mode = "755";
    };

    # Zellij (terminal workspace)
    ".config/zellij" = {
      source = ../../../assets/configs/zellij;
      recursive = true;
      mode = "755";
    };

    # Kitty terminal
    ".config/kitty" = {
      source = ../../../assets/configs/kitty;
      recursive = true;
      mode = "755";
    };

    # Waybar (if not using AGS)
    ".config/waybar" = {
      source = ../../../assets/configs/waybar;
      recursive = true;
      mode = "755";
    };

    # Aylur's GTK Shell (AGS)
    ".config/ags" = {
      source = ../../../assets/configs/ags;
      recursive = true;
      mode = "755";
    };
    # Fastfetch (system info)
    ".config/fastfetch/config.jsonc" = {
      source = ../../../assets/configs/fastfetch/config.jsonc;
    };
    ".config/bottom" = {
      source = ../../assets/configs/bottom/bottom.toml;
    };
    ".config/btop" = {
      source = ../../assets/configs/btop;
      recursive = true;
      mode = "755";
    };
    ".config/cava" = {
      source = ../../assets/configs/cava;
      recursive = true;
      mode = "755";
    };
    ".config/dconf" = {
      source = ../../assets/configs/dconf;
      recursive = true;
      mode = "755";
    };
    ".config/Kvantum" = {
      source = ../../assets/configs/Kvantum;
      recursive = true;
      mode = "755";
    };
    ".config/fastfetch" = {
      source = ../../assets/configs/fastfetch;
      recursive = true;
      mode = "755";
    };
    ".config/nvim" = {
      source = ../../assets/configs/nvim;
      recursive = true;
      mode = "755";
    };
    ".config/nwg-displays" = {
      source = ../../assets/configs/nwg-displays;
      recursive = true;
      mode = "755";
    };
    ".config/nwg-look" = {
      source = ../../assets/configs/nwg-look;
      recursive = true;
      mode = "755";
    };
    ".config/pulse" = {
      source = ../../assets/configs/pulse;
      recursive = true;
      mode = "755";
    };
    ".config/qt5ct" = {
      source = ../../assets/configs/qt5ct;
      recursive = true;
      mode = "755";
    };
    ".config/qt6ct" = {
      source = ../../assets/configs/qt6ct;
      recursive = true;
      mode = "755";
    };
    ".config/rofi" = {
      source = ../../assets/configs/rofi;
      recursive = true;
      mode = "755";
    };
    ".config/swappy" = {
      source = ../../assets/configs/swappy;
      recursive = true;
      mode = "755";
    };
    ".config/swaync" = {
      source = ../../assets/configs/swaync;
      recursive = true;
      mode = "755";
    };
    ".config/xsettingsd" = {
      source = ../../assets/configs/xsettingsd;
      recursive = true;
      mode = "755";
    };

  };
  # User services
  services = {
    # Notification daemon
    mako = {
      enable = true;
      settings = {
        background-color = "#1e1e2e";
        text-color = "#cdd6f4";
        border-color = "#313244";
        border-size = 1;
        border-radius = 8;
        font = "JetBrainsMono Nerd Font 10";
        layer = "top";
      };
    };

    # Power management (alternative to hypridle)
    # https://github.com/xyproto/sleeplock
    hypridle = {
      enable = true;
      settings = {
        lock_cmd = "hyprlock";
        before_sleep = "hyprlock";
      };
    };

    # Clipboard manager
    cliphist = {
      enable = true;
      systemd-wakeup = true;
    };

    # Enable wireplumber (important for audio in Wayland)
    wireplumber.enable = true;
  };

  # Optional: Auto-start apps via systemd
  systemd.user.services."start-hyprland-apps" = {
    description = "Start apps under Hyprland";
    wantedBy = [ "default.target" ];
    after = [ "graphical-session.target" ];
    script = ''
      sleep 3
      ${pkgs.swaybg}/bin/swaybg -i ${../assets/wallpapers/default.jpg} -m fit &
      ${pkgs.swww}/bin/swww init &
      ${pkgs.swww}/bin/swww load ${../assets/wallpapers/default.jpg} &
    '';
    serviceConfig = {
      Type = "forking";
      RemainAfterExit = "yes";
    };
  };
}
