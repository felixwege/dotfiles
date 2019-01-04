#!/bin/bash

alias t="task"
alias tt="clear && task"
alias ta="task add"
alias td="task done"
alias tm="task modify"
alias tw="task waiting"

function tmp {
    task $1 modify project:$2
}

function tmd {
    task $1 modify due:$2
}
