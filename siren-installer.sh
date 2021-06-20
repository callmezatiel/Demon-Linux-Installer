#!/usr/bin/env bash
### Updated for new staging area /var/siren/ ::muscle emoji goes here::
### Douglas Berdeaux FT Zatiel siren Linux, 2021
### Update the installer EACH TIME RAN
DLI_ROOT=/var/siren/installer
GITNAME=siren-Linux-Installer
GITURL=https://github.com/weaknetlabs/${GITNAME}

if [ ! -d $DLI_ROOT ]
  then
    mkdir -p $DLI_ROOT
fi

# Self updating:
updateMe () {
  if [ ! -d ${DLI_ROOT}/${GITNAME} ] # it exists, pull latest
    then # create a local repo:
      mkdir ${DLI_ROOT}/${GITNAME}
      git clone ${GITURL} ${DLI_ROOT}/${GITNAME}
  else # cd into the repo and pull latest:
      printf "[DEBUG] Moving into repository: ${DLI_ROOT}/${GITNAME}\n"
      cd ${DLI_ROOT}/${GITNAME} && git pull ${GITURL}
  fi

  if [ ! -d /usr/share/siren/images/icons ]
    then
      mkdir -p /usr/share/siren/images/icons
  fi

  # copy the new init file:
  cp ${DLI_ROOT}/${GITNAME}/siren-installer.sh /usr/local/sbin/siren-installer.sh
  chmod +x /usr/local/sbin/siren-installer.sh

  # copy the new workflow file:
  cp ${DLI_ROOT}/${GITNAME}/siren-installer-workflow.sh /usr/local/sbin/siren-installer-workflow.sh
  chmod +x /usr/local/sbin/siren-installer-workflow.sh

  # copy the icon images:
  cp ${DLI_ROOT}/${GITNAME}/icons/* /usr/share/siren/images/icons/

  # copy the desktop files:
  cp ${DLI_ROOT}/${GITNAME}/desktop/* /usr/share/applications/

  # complete.
  printf "[!] Updated to the latest version. \n"
}

# Step 1: UPDATE
updateMe
# Step 2: Run the Workflow portion
/usr/local/sbin/siren-installer-workflow.sh
