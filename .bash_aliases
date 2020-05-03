##### Alias definitions #####

##### Para agregar un alias que se pueda repetir en todos los usuarios del sistema sin tener que
##### editar cada archivo .bash_aliases individual = source /etc/custom-shell.sh

##### Command substitution
alias less='less -FRSX'                         # raw control characters (necesario para cygwin)
alias grep='grep -i --color'                    # show differences in colour
alias egrep='egrep --color=auto'                # show differences in colour
alias fgrep='fgrep --color=auto'                # show differences in colour
alias ls='ls -hF --color=tty'                   # classify files in colour
alias df='df -h'                                # Disk free - Default to human readable figures
alias du='du -h'                                # Disk usage - Default to human readable figures
alias ping='ping -c 10'
# Hacer que estos comando pregunten antes de borrar un archivo. Usar -f para que no pregunte.
alias rm='rm -i'                                #Borrar
alias cp='cp -i'                                #Copiar
alias mv='mv -i'                                #Mover
alias nano='nano -BEKi'
alias locate='locate -i'

##### Alias para listar directorios/archivos
alias ll='ls -alhF'
alias lc='ls -aF'
alias lt='ls -1F | xargs file'
alias lll='ls -ldahF .*; ls -lhF'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias l1='ls -l'                               # long list
alias la='ls -A'                               # all but . and ..
alias l2='ls -CF'


##### Listar procesos
alias pf='ps -e | grep'
alias sps='ps aux | grep -v grep | grep'


##### Cuenta el numbero de archivos en el directorio actual
alias numfiles='echo $(ls -1 | wc -l)'
alias numfiles2='find . -maxdepth 1 -type f | wc -l'


##### Cambiar rapidamente a un directorio (musica, documentos, etc)
alias descargas='cd ~/Descargas'
alias videos='cd ~/videos'
alias docu='cd /usr/share/doc ; l | less'
alias progfiles='cd /c/Program\ Files'          # Para cygwin


##### Limitar velocidad en descargas
##### Ej.: sudo apt-get limitar install paquete
alias limitar='-o Acquire::http::Dl-Limit=25'


##### history alias
##### Muestra los 10 comandos más usados
alias hh='history |tr "\011" " "|tr -s " "| cut -d" " -f6 |sort |uniq -c |sort -nbr |head -n10'
##### Busca un comando dentro del history
alias hf='history | grep'


##### Mostrar los tamaños de archivos y directorios en un formato más legible.
# disk usage (du) en formato más legible y ordenado por tamaño
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias ducks='du -cksh * |sort -rn |head -11'


##### Muestra una notificación en pantalla cuando un trabajo (job) que corre en una terminal ha finalizado, usando NotifyOSD
##### ejemplo: sleep 20; alerta
# Options:
#-t: expire time in milliseconds.
#-u: urgency (low, normal, critical).
#-i: icon path.
alias alerta='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[$?] $(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/;\s*alerta$//'\'')"'


##### Notificación más simple pero con una ventana.
alias z='zenity --info --text="Trabajo terminado" --display :0.0'


##### SSH conecciones frecuentes
alias mari='ssh -l mari -p 5196 192.168.0.100'
alias notebook='ssh -X -p 5196 192.168.0.101'
alias ibg-server='ssh -C 192.168.0.111'

##### Arregla problemas de audio con pulseaudio
alias sonido_r='sudo killall -9 pulseaudio; pulseaudio >/dev/null 2>&1 &'


##### head & tail se adaptan al alto de la ventana de la terminal para mostrar el resultado
alias hhead='head -n $((${LINES:-`tput lines 2>/dev/null||echo -n 12`} - 2))'
alias ttail='tail -n $((${LINES:-`tput lines 2>/dev/null||echo -n 12`} - 2))'


##### Ayuda con los formatos de fecha
alias dateh='date --help|sed "/^ *%a/,/^ *%Z/!d;y/_/!/;s/^ *%\([:a-z]\+\) \+/\1_/gI;s/%/#/g;s/^\([a-y]\|[z:]\+\)_/%%\1_%\1_/I"|while read L;do date "+
${L}"|sed y/!#/%%/;done|column -ts_'


##### Escanear archivos y directorios en busca de virus
alias escanear='~/./scanv.sh'


##### Instalar y desisntalar software
alias instalar='sudo aptitude install'
alias desinstalar='sudo aptitude remove --purge'
alias buscarPqauete='apt-cache search'
alias actualizar='sudo aptitude update ; sudo aptitude safe-upgrade'


###### Define a few Color's
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'              # No Color


##### Alias's to control hardware
alias dvdo='eject /dev/dvd'
alias dvdc='eject -t /dev/dvd'


##### Actualizar fuentes instaladas
alias fuentes='sudo fc-cache -f -v'


##### Encontrar pid de los procesos zombies
#alias zombiec='ps aux | awk '{ print $8 " " $2 " " $11 }' | grep -w Z'
alias zombie='ps aux | grep -w --color=always Z | grep -v grep'


##### Power
alias reboot="sudo shutdown -r now"
alias off="sudo shutdown -h now"


##### Git section
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all&'
alias ga='git add .'
alias gp='git push -u origin master'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias this='git init && git add . && git commit -m "primer commit"'
alias got='git '                               #error writting
alias get='git '                               #error writting



##### Misceláneos
alias version='cat /etc/lsb-release'
alias ff='sudo find / -name $1'
alias logs='tail -f /var/log/messages /var/log/*log'
alias conectados='nmap -sP 192.168.0.1-255'
alias apagarMonitor='sleep 1 && xset dpms force off'
