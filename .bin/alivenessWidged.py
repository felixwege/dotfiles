#!/usr/bin/env python3
import yaml
import time
import sys
from pathlib import Path

# append scripts to system path to be able to import labNetwork
sys.path.append(str(Path.home() / 'Repositories/HULKs/nao/scripts/'))

from labNetwork import labNetwork

from alivenessReceiver import NAO
from alivenessReceiver import Status


if __name__ == "__main__":
    if labNetwork():
        try:
            with open('/tmp/aliveness.yml', 'r') as yaml_file:
                status = yaml.load(yaml_file)
            # check the age of the aliveness file
            if time.time() - status.timestamp > 20:
                sys.exit(1)
            widgetString = ""
            for robot in status.robots:
                if robot.lan == True or robot.wlan == True:
                    widgetString += str(robot.headNumber)
                    widgetString += " "
            print(widgetString)
        except IOError as e:
            sys.exit(1)
