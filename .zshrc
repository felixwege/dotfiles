# variables that determine which aliases and functions should be sourced
TASKWARRIOR=true
HULKS=true
EYESIM=true

export VISUAL=nvim
export EDITOR="$VISUAL"

# History
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=999999
export HISTFILESIZE=999999

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin/:$PATH

# Append cuda to $LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cuda/lib64

export ANDROID_HOME=/home/felix/Android/sdk
export ANDROID_SDK_ROOT=/home/felix/Android/sdk
export ANDROID_AVD_HOME=/home/felix/.android/avd

# append eyesim lib to LD_LIBRARY_PATH
if [ $EYESIM = true ]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
fi

source ~/.zplug/init.zsh

# Let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'


# additional completions
zplug "zsh-users/zsh-completions"


# git aliases
zplug "plugins/git",   from:oh-my-zsh


# Notify about existing alias
zplug "MichaelAquilina/zsh-you-should-use"


# zsh-autosuggestions
zplug "zsh-users/zsh-autosuggestions"

# ctrl+Space to accept autosuggestions
bindkey '^ ' autosuggest-accept


# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2


# wd (warp directory)
zplug "mfaerevaag/wd", as:command, use:"wd.sh", hook-load:"wd() { . $ZPLUG_REPOS/mfaerevaag/wd/wd.sh }"


# Colorize output of various programs
zplug "zpm-zsh/colorize"


# Theme
zplug "themes/ys", from:oh-my-zsh


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load


# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# images
function img {
    sxiv -r $@ >/dev/null 2>&1 &
}

# pdf
function pdf {
    if [[ $1 == *.pdf ]]; then
        evince $1 >/dev/null 2>&1 &
    elif [[ -d $1 ]]; then
        for f in $1/*.pdf; do
            evince $f >/dev/null 2>&1 &
        done
    fi
}

# load screen layout and set background
function fehrandr {
    if [ -n "$1" ]; then
        $1 && $HOME/.fehbg
    else
        echo "please specify xrandr command or load arandr screenlayout"
    fi
}


# Weather
function wttr {
    if [ -n "$1" ]; then
        curl wttr.in/$1
    else
        curl wttr.in
    fi
}

function md2pdf {
    if [[ $1 == *.md ]]; then
        # strip file extension with shell parameter expansion
        pandoc -o ${1%.*}.pdf $1
    else
        echo "please give me a markdown file"
    fi
}

# transpile typescript file and run node
function tscnode {
    if tsc "$@"; then
        FILENAME="${1%.*}"
        node "${FILENAME}".js
    fi
}

# combine mkdir and cd
function mkcd {
    mkdir $1 && cd $1
}

# git merge squash
function gms {
    trackingBranch=$1
    git merge --squash $trackingBranch || { echo 'merge-squashing failed' ; return 1; }
    git commit -m "squashed $trackingBranch"
}

# git cherry-spit
function gcsp {
    if [ "$#" -ne 2 ]; then
        echo "please give me 2 parameters (a commit hash and a branch name)"
        return 1;
    fi
    echo "cherry-spitting $1 onto $2"
    git checkout $2 || { echo 'cherry-spit failed' ; return 1; }
    git cherry-pick $1 || { return 1; }
    git checkout -
}

alias l="ls -lah --color"

# additional git aliases
alias grl="git reflog"
alias gdn="git diff --name-only"
alias gdc="git diff --compact-summary"
alias gstw="git stash show"
alias gstap="git stash push --patch"
alias gcop="git checkout --patch"

# open terminal in current directory (single parenthesis is required to evaulate current pwd)
alias here='termite -d $(pwd) > /dev/null 2>&1 &'

# cd to home and clear terminal
alias fresh="cd && clear"

# alsamixer
alias am='alsamixer'

# preserve user environment
alias svim="sudo -E vim"

# lazygit
alias lg="lazygit"

# task warrior
if [ $TASKWARRIOR = true ]; then
    source ~/.aliases/taskwarrior.sh
fi

# hulks
if [ $HULKS = true ]; then
    source ~/.aliases/hulks.sh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
