#!/bin/zsh

#*---------------- LICENSE REGISTRATION -----------------*#

# Gathers user's registered Parallels email address
# let EMAIL=

# Gathers the Parallels license key
# let LICENSE= 

# Defines the macOS Template and Clone names
# let TEMPLATE="MOS14-1-1"
# let CLONE= 


#*------- The following steps must be completed together -----*#

# Signs into Parallels website - REQUIRED TO INSTALL LICENSE
# prlsrvctl web-portal signin $EMAIL

# TODO: Installs license - WEB PORTAL SIGN-IN REQUIRED BEFORE THIS STEP
# prlsrvctl install-license -k $LICENSE


#*------------------ VM CONFIGURATION ------------------*#


# TODO: Downloads the .ipsw file & creates the VM
curl https://updates.cdn-apple.com/2023FallFCS/fullrestores/042-89681/55BD14DB-5535-4203-9359-E2C070E43FBE/UniversalMac_14.1.1_23B81_Restore.ipsw \
--create-dirs --output /Users/Shared/Parallels/MOS14-1-1.ipsw \
&& chmod +x "${_}"

# Source file location
let INSTALLER="/Users/Shared/Parallels/MOS14-1-1.ipsw"

# Specifies the VM installation path
let VMPATH="$HOME/Parallels/MOS14.1-Template.macvm"

# Creates the VM from the .ipsw file
prlctl create "MOS14.1-Template" -o macos --restore-image $INSTALLER

# Registers the VM in Parallels Desktop
prlctl register $VMPATH

# Disables auto-start--required to prevent the Mac from booting before adjusting storage size
prlctl set --autostart off

# Changes to the VM installation directory
cd $HOME/Parallels/MOS14.1-Template.macvm

# Increases storage drive to 100GB before boot
truncate -s 100G disk0.img

# Adds "bridge" virtual network interface
# prlsrvctl net set -i "Bridged" -t bridged -d "Bridged mode with host machine" --dhcp-server on

# Starts the VM & completes first-time setup
prlctl start MOS14.1-Template

echo "Made it this far"

#*------------- macOS Automated Setup ---------------*#

# TODO: macOS Automated Setup
# 
# ...



#*------------- TEMPLATE + VM CREATION ---------------*#

# Shuts down the VM after configuration
# prlsvrctl shutdown -f


# Converts the VM to a template to act as a Snapshot
# prlctl set $TEMPLATE on

# Clones the macOS VM so the template acts as a snapshot restore point
# prlctl create $TEMPLATE --ostemplate $CLONE
