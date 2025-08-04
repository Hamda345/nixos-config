# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only

{ pkgs, username, ... }:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "wireshark"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
        "libvirtd"
        "kvm"
      ];

      # define user packages here
      packages = with pkgs; [
        zsh-powerlevel10k
      ];
    };

    defaultUserShell = pkgs.zsh;
  };

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ lsd fzf ];

  programs = {
    # Zsh configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "";
      };

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      promptInit = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

          [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
          fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

          #pokemon colorscripts like. Make sure to install krabby package
          #krabby random --no-mega --no-gmax --no-regional --no-title -s; 

          # Set-up icons for files/directories in terminal using lsd
          alias ls='lsd'
          alias l='ls -l'
          alias la='ls -a'
          alias lla='ls -la'
          alias lt='ls --tree'

          source <(fzf --zsh);
          HISTFILE=~/.zsh_history;
          HISTSIZE=10000;
          SAVEHIST=10000;
          setopt appendhistory;
      '';
    };
  };
}
