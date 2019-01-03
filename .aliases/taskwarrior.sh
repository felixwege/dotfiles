#!/bin/bash

alias t="task"
alias tt="clear && task"
alias ta="task add"
alias td="task done"
alias tm="task modify"

function tap {
    task add $1 project:$2
}

function tad {
    task add $1 due:$2
}

function tapd {
    task add $1 pro:$2 due:$3
}

function tmp {
    task $1 modify project:$2
}

function tmd {
    task $1 modify due:$2
}
