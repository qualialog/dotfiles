export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

export EDITOR="nvim"
export VISUAL="nvim"

export SHELL_SESSION_DIR="$XDG_STATE_HOME/zsh/sessions"
export SHELL_SESSION_FILE="$SHELL_SESSION_DIR/$TERM_SESSION_ID"

export HISTFILE=$XDG_STATE_HOME/zsh/history

autoload compinit
compinit -i -d "$XDG_CACHE_HOME/zsh/completions/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

export PATH=$PATH:~/Library/Python/3.9/bin

HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

setopt auto_cd

for f ($XDG_CONFIG_HOME/zsh/scripts/**/*(N.)) . $f

source ~/zsh-autosuggestions/zsh-autosuggestions.zsh

alias C="clear"
alias c="clear"

eval "$(zoxide init zsh)"
