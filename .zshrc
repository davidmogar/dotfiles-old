# Path to oh-my-zsh installation
export ZSH=/home/david/.oh-my-zsh

# Set name of the theme to load
ZSH_THEME="nebirhos"

# CASE_SENSITIVE="true"                   # case sensitive completion
# HYPHEN_INSENSITIVE="true"               # hyphen-insensitive completion
# DISABLE_AUTO_UPDATE="true"              # disable bi-weekly auto-update checks
# export UPDATE_ZSH_DAYS=13               # days between auto-updates
# DISABLE_LS_COLORS="true"                # disable ls colors
# DISABLE_AUTO_TITLE="true"               # disable auto-setting terminal title
# ENABLE_CORRECTION="true"                # enable auto-correction
# COMPLETION_WAITING_DOTS="true"          # display red dots whils waiting for completion
# DISABLE_UNTRACKED_FILES_DIRTY="true"    # disable marking untracked files under VCS as disty
# HIST_STAMPS="mm/dd/yyyy"                # Execution time stamp
ZSH_CUSTOM=~/.zsh                         # zsh custom folder (default ~/.zsh)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux websearch)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

eval `dircolors ~/.dir_colors/dircolors`
