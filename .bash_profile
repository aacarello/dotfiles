#########################################################################
#         .bash_profile: Personal initialisation file for bash          #
#########################################################################

# This script file is executed by bash(1) for login shells.  By default,
# it does nothing, as ~/.bashrc is already sourced by /etc/profile.
#



# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# Set PATH so it includes user's private script folder if it exists
if [ -d "${HOME}/.scripts" ] ; then
    PATH="${HOME}/.scripts:${PATH}"
fi

# Set PATH so it includes user's private bin folder if it exist
if [ -d "${HOME}/.bin" ] ; then
    PATH="${HOME}/.bin:${PATH}"
fi
