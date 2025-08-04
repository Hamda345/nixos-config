# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

#export ZSH="$HOME/.oh-my-zsh"

# Set-up icons for files/directories in terminal
alias ls='lsd -a'
alias ll='lsd -al'
# alias lt='eza -a --tree --level=1 --icons'
alias v='nvim'
alias z='zellij'
alias q='exit'
# Starting down here, are set in user.nix

ZSH_THEME="xiong-chiamiov-plus"

plugins=(
   git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completion
    fzf-tab
)

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r


# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':zsh-completions:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':zsh-completions:*' menu no
zstyle 'fzf-tab:complete:eza:*' fzf-preview 'eza $realpath'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
