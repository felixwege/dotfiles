export VISUAL=nvim
export EDITOR="$VISUAL"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then
    # plugins
    zgen oh-my-zsh
    zgen oh-my-zsh themes/ys
    zgen oh-my-zsh plugins/git
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load mfaerevaag/wd

    # generate the init script from plugins above (remember to call zgen update and zgen reset)
    zgen save
fi

# ctrl+Space to accept autosuggestions
bindkey '^ ' autosuggest-accept

# combine mkdir and cd
function mkcd {
    mkdir $1 && cd $1
}

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

# weather
function wttr {
    if [ -n "$1" ]; then
        curl wttr.in/$1
    else
        curl wttr.in
    fi
}

# additional git aliases
alias grl="git reflog"
alias gdn="git diff --name-only"
alias gdc="git diff --compact-summary"
alias gstw="git stash show"
alias gstap="git stash push --patch"
alias gcop="git checkout --patch"

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

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
