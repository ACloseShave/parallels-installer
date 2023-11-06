#!/bin/zsh

#*---------------- LICENSE REGISTRATION -----------------*#

# Gathers user's registered Parallels email address
# let EMAIL=


# Gathers the Parallels license key
# let LICENSE= 

# Defines the macOS Template and Clone names
# let TEMPLATE= 
# let CLONE= 

# Signs into Parallels website
# prlsrvctl web-portal signin $EMAIL


# TODO: Installs license
# prlsrvctl install-license -k $LICENSE


#*------------------ VM CONFIGURATION ------------------*#


# TODO: Downloads the .ipsw file & creates the VM
curl https://updates.cdn-apple.com/2023FallFCS/fullrestores/042-86430/DBE44960-58A6-4715-948B-D64F33F769BD/UniversalMac_14.1_23B74_Restore.ipsw \
  --create-dirs --output /Users/Shared/Parallels/MOS14-1.ipsw \
  && chmod +x "${_}"

# mv
prlctl create "MOS14.1-Template" -o macos --restore-image $HOME/Parallels/MOS14-1.ipsw

# Source file location
let INSTALLER="/Users/Shared/Parallels/MOS14-1.ipsw"

# Specifies the VM installation path
let VMPATH="~/Parallels/MOS-14.1.macvm"

# Registers the VM in Parallels Desktop
prlctl register ~/Parallels/MOS14.1-Template.macvm

# Changes to the VM installation directory
cd ~/Parallels/MOS14.1-Template.macvm

# Increases storage drive to 100GB before boot
truncate -s 100G disk0.img

# Adds "bridge" virtual network interface
prlctl net set -i "Bridged" -t bridged -d "Bridged mode with host machine" --dhcp-server on

# Starts the VM & completes first-time setup
prlctl start MOS14.1-Template
# setup instructions?


#*------------- TEMPLATE + VM CREATION ---------------*#

# Shuts down the VM after configuration
# prlsvrctl shutdown -f


# Converts the VM to a template to act as a Snapshot
# prlctl set $TEMPLATE on

# Clones the macOS VM so the template acts as a snapshot restore point
# prlctl create $TEMPLATE --ostemplate $CLONE
