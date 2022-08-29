#!/bin/bash

# refreshes the list of available updates
sudo apt update
# upgrades packages
sudo apt -y upgrade
# removes packages that are no longer required
sudo apt autoremove
