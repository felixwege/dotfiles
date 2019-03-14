#!/bin/bash

# start SimRobot, GameController, TeamCommunicationMonitor or mate
alias simrobot="$HOME/Repositories/HULKs/nao/tools/SimRobot/build/SimRobot"
alias gamecontroller="cd $HOME/Repositories/HULKs/GameController/build/jar/; java -jar GameController.jar --window --game-type preliminary &; popd"
alias teamcommunicationmonitor="cd $HOME/Repositories/HULKs/GameController/build/jar/; java -jar TeamCommunicationMonitor.jar --window &; popd"
alias mate="~/.venv/nao/bin/python ~/Repositories/HULKs/nao/tools/mate/run.py"

# official robocup spl rules
alias rules="pdf ~/Documents/HULKs/Rules2019.pdf"
