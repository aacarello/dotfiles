##### Functions definitions #####


##### Editar archivos
# Pequeño script, para editar archivos y si es de solo lectura usa "sudo"
function edit() {
EDITOR="geany"
if [ -w $1 ] ; then
    $EDITOR "$1" &
else
    gksudo $EDITOR "$1" &
fi
}

##### Reminder for whatever whenever
function remindme()
{
sleep $1 && zenity --info --text "$2" &
}


##### Procedimientos para hacer backups de archivos
#
function bak {
if [ -w $1 ] ; then
    cp $1{,.bak}
else
    sudo cp $1{,.bak}
fi
}


function bak2 ()
{
if [ -w $1 ] ; then
    cp $1 $1_`date +%H:%M:%S_%d-%m-%Y`.backup
else
    sudo cp $1 $1_`date +%H:%M:%S_%d-%m-%Y`.backup
fi
}


# backup files--> ~/.backup/
bu ()
{
    if [ "`dirname $1`" == "." ]; then
        mkdir -p ~/.backup/`pwd`;
        cp $1 ~/.backup/`pwd`/$1-`date +%Y%m%d%H%M`.backup;
    else
        mkdir -p ~/.backup/`dirname $1`;
        cp $1 ~/.backup/$1-`date +%Y%m%d%H%M`.backup;
    fi
}


##### Makes directory then moves into it
function mkcdr {
    mkdir -p -v $1
    cd $1
}


##### Change directory and list files
function cds(){
    # only change directory if a directory is specified
    [ -n "${1}" ] && cd $1
    lll                                         # Alias de ls
}


##### Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }


##### Automatically inputs aliases here in '.bash_aliases'
# Usage: mkalias <name> "<command>"
# Example: mkalias rm "rm -i"
function mkalias ()
{
        if [[ $1 && $2 ]]
        then
        echo -e "alias $1=\"$2\"" >> ~/.bash_aliases
        alias $1=$2
        fi
}


##### Procedimiento para ver archivos de logs coloreados
##### requiere tener instalado ccze
function ver {
    ccze -A < $1 | less -R
}


##### Alias's to generate a strong password
genpasswd() {
    local l=$1
        [ "$l" == "" ] && l=20
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}


##### Extract Files
extract() {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.xz)        unxz $1        ;;
          *.exe)       cabextract $1  ;;
          *)           echo "\`$1': unrecognized file compression" ;;
      esac
  else
      echo "\`$1' is not a valid file"
  fi
}


##### Nice mount output
nmount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t; }


##### Sets tittle on windows title
function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }


##### googl - short urls
# usage: googl <url>
googl () { curl -s -d "url=${1}" http://goo.gl/api/url | sed -n "s/.*:\"\([^\"]*\).*/\1\n/p" ;}


##### mkmine - recursively change ownership to $USER:$USER
# usage:  mkmine, or
#         mkmine <filename | dirname>
function mkmine() { sudo chown -R ${USER} ${1:-.}; }


##### Nohup - run command detached from terminal and without output
# usage: nh <command>
function nh() { nohup "$@" &>/dev/null & }


##### Send public key to remote server
# usage: sendkey <user@remotehost>
sendkey()
{
    if [ $# -ne 1 ]; then
        ssh $1 'cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_dsa.pub
    fi
}

# show message with notification-daemon.
msg() {
eval $* && notify-send "Shell Information" "「$*」has done." -i 'dialog-apply1' -t '2000' \
|| notify-send "Shell Information" "「$*」has Failed." -i 'application-exit1' -t '2000'
}



#
# Some example functions:
#

#
# function cd_func
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
# cd_func ()
# {
#   local x2 the_new_dir adir index
#   local -i cnt
#
#   if [[ $1 ==  "--" ]]; then
#     dirs -v
#     return 0
#   fi
#
#   the_new_dir=$1
#   [[ -z $1 ]] && the_new_dir=$HOME
#
#   if [[ ${the_new_dir:0:1} == '-' ]]; then
#     #
#     # Extract dir N from dirs
#     index=${the_new_dir:1}
#     [[ -z $index ]] && index=1
#     adir=$(dirs +$index)
#     [[ -z $adir ]] && return 1
#     the_new_dir=$adir
#   fi
#
#   #
#   # '~' has to be substituted by ${HOME}
#   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
#
#   #
#   # Now change to the new dir and add to the top of the stack
#   pushd "${the_new_dir}" > /dev/null
#   [[ $? -ne 0 ]] && return 1
#   the_new_dir=$(pwd)
#
#   #
#   # Trim down everything beyond 11th entry
#   popd -n +11 2>/dev/null 1>/dev/null
#
#   #
#   # Remove any other occurence of this dir, skipping the top of the stack
#   for ((cnt=1; cnt <= 10; cnt++)); do
#     x2=$(dirs +${cnt} 2>/dev/null)
#     [[ $? -ne 0 ]] && return 0
#     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#     if [[ "${x2}" == "${the_new_dir}" ]]; then
#       popd -n +$cnt 2>/dev/null 1>/dev/null
#       cnt=cnt-1
#     fi
#   done
#
#   return 0
# }
#
# alias cd=cd_func

##### --------------------------------------------------------------------------------

