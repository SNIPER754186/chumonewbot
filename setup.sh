#!/bin/bash
# Este script ha sido desofuscado a partir de la URL original.
# Creado por Henry Chumo | @ChumoGH (basado en la autoría original)

clear
# Directorios de instalación
[[ ! -d /etc/http-shell ]] && mkdir /etc/http-shell
[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="cabecalho menu_credito ferramentas menu_inst PPub.py usercodes ferramentascodes payloads ssl paysnd.sh PDirect.py v-local.log PGet.py ultrahost menu POpen.py shadowsocks.sh fai2ban PPriv.py"
IVAR="/etc/http-instas"

# Carga de estilos (originalmente desde un enlace remoto, aquí se simula que ya están disponibles)
# En un entorno real, asegurarías que 'styles.cpp' esté disponible localmente o lo descargarías.
source /dev/null # Placeholder: asume que las funciones de estilo están definidas.
# --- INICIO DE DEFINICIÓN DE FUNCIONES DE ESTILO (Reemplazo de styles.cpp) ---
export c_default="\033[0m"
export c_blue="\033[1;34m"
export c_magenta="\033[1;35m"
export c_cyan="\033[1;36m"
export c_green="\033[1;32m"
export c_red="\033[1;31m"
export c_yellow="\033[1;33m"

anim=(
  "${c_blue}•${c_green}•${c_red}•${c_magenta}•    "
  " ${c_green}•${c_red}•${c_magenta}•${c_blue}•   "
  "  ${c_red}•${c_magenta}•${c_blue}•${c_green}• "
  "    ${c_magenta}•${c_blue}•${c_green}•${c_red}• "
  "     ${c_blue}•${c_green}•${c_red}•${c_magenta}•"
)

start_animation() {
  [[ "${silent_mode}" == "true" ]] && return 0
  setterm -cursor off
  (
    while true; do
      for i in {0..4}; do
        echo -ne "\r\033[2K                    ${anim[i]}"
        sleep 0.1
      done
      for i in {4..0}; do
        echo -ne "\r\033[2K                    ${anim[i]}"
        sleep 0.1
      done
    done
  ) &
  export ANIM_PID="${!}"
}

stop_animation() {
  [[ "${silent_mode}" == "true" ]] && return 0
  [[ -e "/proc/${ANIM_PID}" ]] && kill -13 "${ANIM_PID}"
  setterm -cursor on
}

_sleepColor(){
local time=$1
local accion=$2
start_animation
[[ -z ${accion} ]] && {
[[ -z ${time} ]] && sleep 2s || sleep ${time}
} || ${accion} &>/dev/null
stop_animation
echo
tput cuu1 >&2 && tput dl1 >&2
}

# Funciones msg, msg -bar, etc., estarían aquí (simplificadas para el ejemplo)
msg() {
  case $1 in
    -bar) echo -e "----------------------------------------------------" ;;
    -bar3) echo -e "----------------------------------------------------" ;;
    -verd) echo -e "${c_green}${2}${c_default}" ;;
    -azu) echo -e "${c_blue}${2}${c_default}" ;;
    -bra) echo -e "${c_default}${2}${c_default}" ;;
    # Añadir más casos de msg según la definición original de styles.cpp
    *) echo -e "$*" ;;
  esac
}

tittle () {
    clear
    msg -bar
    echo -e "${c_green}$1${c_default}" | awk '{printf "%*s\n", (80+length())/2, $0}' # Centrado básico
    msg -bar
}

# --- FIN DE DEFINICIÓN DE FUNCIONES DE ESTILO ---

# IP detection
check_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}

# IP and authorization check (Kill Switch)
# Originalmente descarga de una URL ofuscada, aquí se muestra el propósito
# En tu implementación, reemplazarías esto con tu propio archivo de control local
# o eliminarías esta lógica si no necesitas un sistema de licencia basado en IP.
check_ip # Asegura que IP esté definida antes de usarla

# ATENCIÓN: Esta sección es el "kill switch" remoto.
# En tu implementación bajo control, esto DEBE ser reemplazado por tu propia lógica local
# o eliminado por completo si no deseas un control remoto de las instancias.
# permited=$(curl -sSL "https://raw.githubusercontent.com/SNIPER754186/chumonewbot/refs/heads/LaTamSRC/source/Control-Bot.txt")
# if [[ $(echo "$permited" | grep "$(wget -qO- ifconfig.me)") = "" ]]; then
#     rm -rf /etc/SCRIPT
#     systemctl disable BotGen-server.service
#     systemctl stop BotGen-server.service
#     rm -rf /etc/ADM-db
#     echo -e "${c_red}Su IP no está autorizada. El sistema ha sido deshabilitado.${c_default}"
#     exit 1
# fi
# Simulación de autorización exitosa para continuar el script
echo "AUTHORIZED_IP_OK" > /tmp/ip_auth_status # Marcador temporal


SCPT_DIR="/etc/SCRIPT"
SCPT_LTM="/etc/LTM"
[[ ! -e ${SCPT_LTM} ]] && mkdir ${SCPT_LTM}
[[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
DIR="/etc/http-shell"
LIST="-SPVweN" # Nombre del archivo que lista los scripts dentro de cada key dir
v1g=$(cat /bin/ejecutar/vG-new.log 2>/dev/null) # Versión remota del generador
v1=$(cat /bin/ejecutar/v-new.log 2>/dev/null) # Versión remota del script
v2=$(cat < ${SCPT_DIR}/v-local.log 2>/dev/null) # Versión local del script
v2g=$(cat < /bin/ejecutar/vG-local.log 2>/dev/null) # Versión local del generador

# Obtención de IP (repetida, pero mantenida para fidelidad al original)
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

# Ofuscación/Desofuscación (funciones de César simple)
ofusLTM() {
  unset txtofus
  number=$(expr length "$1")
  for ((i = 1; i < number + 1; i++)); do
    txt[$i]=$(echo "$1" | cut -b "$i")
    case ${txt[$i]} in
    ".") txt[$i]="v" ;;
    "v") txt[$i]="." ;;
    "1") txt[$i]="@" ;;
    "@") txt[$i]="1" ;;
    "2") txt[$i]="?" ;;
    "?") txt[$i]="2" ;;
    "4") txt[$i]="p" ;;
    "p") txt[$i]="4" ;;
    "-") txt[$i]="L" ;;
    "L") txt[$i]="-" ;;
    esac
    txtofus+="${txt[$i]}"
  done
  echo "$txtofus" | rev
}

ofus () {
unset txtofus
number=$(expr length "$1")
for((i=1; i<number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b "$i")
case ${txt[$i]} in
".")txt[$i]="x";;
"x")txt[$i]=".";;
"5")txt[$i]="s";;
"s")txt[$i]="5";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="0";;
"0")txt[$i]="4";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}

# --- FUNCIONES CENTRALES DEL INSTALADOR ---

# Función para la instalación inicial de paquetes
install_ini () {
clear&&clear
rm -f gera*
add-apt-repository universe -y > /dev/null 2>&1
apt update -y; apt upgrade -y
msg -bar
echo -e "${c_green}        -- INSTALANDO PAQUETES NECESARIOS -- ${c_default}"
msg -bar

locale-gen en_US.UTF-8 > /dev/null 2>&1
update-locale LANG=en_US.UTF-8 > /dev/null 2>&1
echo -e "${c_default}  # Instalando  UTF...................... ${c_green}INSTALADO${c_default} "

apt-get install gawk -y > /dev/null 2>&1
echo -e "${c_default}  # apt-get install gawk................... ${c_green}INSTALADO${c_default} "

# jq
if ! dpkg --get-selections | grep -w "jq" &>/dev/null; then
  apt-get install jq -y &>/dev/null
  if ! dpkg --get-selections | grep -w "jq" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install jq................... $ESTATUS "

# SCREEN
if ! dpkg --get-selections | grep -w "screen" &>/dev/null; then
  apt-get install screen -y &>/dev/null
  if ! dpkg --get-selections | grep -w "screen" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install screen............... $ESTATUS "

# nginx
if ! dpkg --get-selections | grep -w "nginx" &>/dev/null; then
  apt-get install nginx -y &>/dev/null
  echo '
server {
        listen 81 default_server;
        listen [::]:81 default_server;
        root /var/www/html;
        index index.html index.htm index.php;
        server_name _;
        location / {
                try_files $uri $uri/ =404;
        }
}
' > /etc/nginx/sites-available/default
  rm -rf /usr/share/nginx/html
  sudo ln -s /var/www/html /usr/share/nginx/html
  service nginx restart > /dev/null 2>&1 &
  if ! dpkg --get-selections | grep -w "nginx" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
# Purga apache2 si está presente
if dpkg --get-selections | grep -w "apache2" &>/dev/null; then apt purge apache2 -y &>/dev/null; fi
echo -e "${c_default}  # apt-get install nginx................ $ESTATUS "

# curl
if ! dpkg --get-selections | grep -w "curl" &>/dev/null; then
  apt-get install curl -y &>/dev/null
  if ! dpkg --get-selections | grep -w "curl" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install curl................. $ESTATUS "

# socat
if ! dpkg --get-selections | grep -w "socat" &>/dev/null; then
  apt-get install socat -y &>/dev/null
  if ! dpkg --get-selections | grep -w "socat" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install socat................ $ESTATUS "

# netcat
if ! dpkg --get-selections | grep -w "netcat" &>/dev/null; then
  apt-get install netcat -y &>/dev/null
  if ! dpkg --get-selections | grep -w "netcat" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install netcat............... $ESTATUS "

# netcat-traditional
if ! dpkg --get-selections | grep -w "netcat-traditional" &>/dev/null; then
  apt-get install netcat-traditional -y &>/dev/null
  if ! dpkg --get-selections | grep -w "netcat-traditional" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install netcat-traditional... $ESTATUS "

# net-tools
if ! dpkg --get-selections | grep -w "net-tools" &>/dev/null; then
  apt-get install net-tools -y &>/dev/null
  if ! dpkg --get-selections | grep -w "net-tools" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install net-tools............ $ESTATUS "

# cowsay
if ! dpkg --get-selections | grep -w "cowsay" &>/dev/null; then
  apt-get install cowsay -y &>/dev/null
  if ! dpkg --get-selections | grep -w "cowsay" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install cowsay............... $ESTATUS "

# figlet
if ! dpkg --get-selections | grep -w "figlet" &>/dev/null; then
  apt-get install figlet -y &>/dev/null
  if ! dpkg --get-selections | grep -w "figlet" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install figlet............... $ESTATUS "

# lolcat
# Esto a menudo requiere 'gem install lolcat' además de 'apt-get install'
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
if ! dpkg --get-selections | grep -w "lolcat" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install lolcat............... $ESTATUS "

# at
if ! dpkg --get-selections | grep -w "at" &>/dev/null; then
  apt-get install at -y &>/dev/null
  sudo apt install at -y&>/dev/null
  if ! dpkg --get-selections | grep -w "at" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install at................... $ESTATUS "

# PV
if ! dpkg --get-selections | grep -w "pv" &>/dev/null; then
  apt-get install pv -y &>/dev/null
  if ! dpkg --get-selections | grep -w "pv" &>/dev/null; then ESTATUS="${c_red}FALLO DE INSTALACION${c_default}"; else ESTATUS="${c_green}INSTALADO${c_default}"; fi
else ESTATUS="${c_green}INSTALADO${c_default}"; fi
echo -e "${c_default}  # apt-get install PV   ................ $ESTATUS "

msg -bar
echo -e "${c_green} La instalacion de paquetes necesarios ha finalizado${c_default}"
msg -bar
} # Fin de install_ini

# --- FUNCIONES DE DESCARGA Y TRASLADO DE ARCHIVOS ---
# ChumoGH files
fun_filez () {
fup="$HOME/update"
echo "$1" >> $HOME/files.log
[[ "$1" = 'http-server.py' ]] && mv "${fup}/$1" /bin/http-server.sh && chmod +x /bin/http-server.sh
[[ -e "$HOME/update/$1" ]] && mv -f "${fup}/$1" "${SCPT_DIR}/$1"
}

# LTM files
fun_filezLTM () {
fup="$HOME/update"
echo "$1" >> $HOME/files.log
[[ -e "$HOME/update/$1" ]] && mv -f "${fup}/$1" "${SCPT_LTM}/$1"
}

# Actualiza scripts ChumoGH
atualiza_fun () {
msg -bar
[[ -d $HOME/update ]] && rm -rf $HOME/update/*
[[ ! -d $HOME/update ]] && mkdir $HOME/update || rm -f $HOME/update/*
cd $HOME/update/
msg -bar
echo -e "${c_yellow}Descargando ChumoGH... ESPERE ${c_default}"
msg -bar
# ATENCIÓN: Este es un enlace remoto. En tu control, cámbialo a tu propio repositorio.
wget -q --no-check-certificate -O $HOME/files.tar.gz https://github.com/SNIPER754186/chumonewbot/raw/refs/heads/LaTamSRC/SCRIPTS/ADMcgh/SCRIPT.tar.gz
[[ -e $HOME/files.tar.gz ]] && tar -xzvf $HOME/files.tar.gz -C $HOME/update &> /dev/null
rm -f $HOME/files.tar.gz
chmod 666 $HOME/update/*
rm -f $HOME/files.log
for arqs in `ls $HOME/update`; do
echo -ne "${c_yellow} FILE ${c_green} [${arqs}.CGH.${n}] ${c_default} "
fun_filez "$arqs" > /dev/null 2>&1 && echo -e "${c_red}- ${arqs} (no Trasladado!)${c_default}" || echo -e "${c_green}- ${arqs} Trasladado!${c_default}"
n=$(($n + 1))
done
# ATENCIÓN: Este es un enlace remoto para el comando kcgh. Cámbialo a tu propio repositorio.
echo 'source <(curl -sSL https://raw.githubusercontent.com/Qm90R2VuIDIwMjQgQ2h1bW9HSCsK/U291cmNlIEJvckdlbiBBRE1jZ2ggQ2h1bW9HSCAyMDI0IFBsdXM-/main/Gestor/gerar.sh)' > /bin/kcgh && chmod +x /bin/kcgh
cd $HOME
rm -f $HOME/lista
rm -rf $HOME/update
rm -f $HOME/files.tar.gz
}

# Actualiza scripts LATAM
atualiza_funLTM () {
msg -bar
[[ -d $HOME/update ]] && rm -rf $HOME/update/* || mkdir $HOME/update
cd $HOME/update/
msg -bar
echo -e "${c_yellow}Descargando LATAM... ESPERE ${c_default}"
msg -bar
# ATENCIÓN: Este es un enlace remoto. En tu control, cámbialo a tu propio repositorio.
wget -q --no-check-certificate -O $HOME/files.tar.gz https://www.dropbox.com/s/z16y8r2pqurbz4t/SCRIPT.tar.gz
[[ -e $HOME/files.tar.gz ]] && tar -xzvf $HOME/files.tar.gz -C $HOME/update &> /dev/null
rm -f $HOME/files.tar.gz
chmod 666 $HOME/update/*
rm -f $HOME/files.log
for arqs in `ls $HOME/update`; do
echo -ne "${c_yellow} FILE ${c_green} [${arqs}.LTM.${n}] ${c_default} "
fun_filezLTM "$arqs" > /dev/null 2>&1 && echo -e "${c_red}- ${arqs} (no Trasladado!)${c_default}" || echo -e "${c_green}- ${arqs} Trasladado!${c_default}"
n=$(($n + 1))
done
cd $HOME
rm -f $HOME/lista
rm -rf $HOME/update
rm -f $HOME/files.tar.gz
}

# --- OTRAS FUNCIONES RELEVANTES DEL KEYGEN / PANEL DE CONTROL ---

# (Las siguientes funciones son similares a las vistas en scripts anteriores y serían parte de este 'setup' desofuscado)

# mudar_instacao () { ... } # Permite seleccionar archivos a incluir en la Key
# list_fix () { ... }      # Prepara los archivos para una nueva Key
# fix_key () { ... }       # Genera nuevas Keys
# att_gen_key () { ... }   # Actualiza Keys existentes
# del_KILL () { ... }      # Elimina directorios de Keys sin nombre
# remover_key () { ... }   # Elimina Keys manualmente
# remover_key_usada () { ... } # Elimina Keys usadas/antiguas
# start_gen () { ... }     # Inicia/detiene el servidor HTTP Keygen (http-server.sh)
# message_gen () { ... }   # Configura mensajes de crédito/contacto
# act_gen () { ... }       # Menú para actualización (créditos, ficheros, reinstalar)
# rmv_iplib () { ... }     # Lista IPs de generadores activos
# bot_menu () { ... }      # Respalda/restaura configs del bot y lo instala (setup.bot)
# fum_ver () { ... }       # Menú de verificación de Keys (ChumoGH/LATAM)
# fum_verCGH () { ... }    # Verificación de Key ChumoGH
# fum_verLTM () { ... }    # Verificación de Key LATAM
# ipbot () { ... }         # Autoriza/desautoriza IPs para el Bot
# alter_id () { ... }      # Altera créditos por ID o reinicia contador total
# alter_limit () { ... }   # Altera el límite global de Keys
# dropIP() { ... }         # Gestiona el servicio dropIP.service

# --- LÓGICA PRINCIPAL DE EJECUCIÓN ---

# Verifica la IP y el "Kill Switch" remoto
# Esto se ha manejado al inicio del script desofuscado
# (Aquí debería ir la lógica para manejar el argumento $PAM si es '--ADMcgh')
check_ip

# Lógica del flujo principal basado en el argumento $PAM
if [[ "$PAM" == '--ADMcgh' ]]; then
  install_ini # Realiza la instalación inicial de paquetes
  clear&&clear
  msg -bar
  echo -e "${c_green}    ${c_yellow} GEN ChumoGH${c_default}${c_blue}VPS ${c_default}      ${c_default}"
  msg -bar
  echo -e " ${c_yellow}IP $(wget -qO- ifconfig.me) VERIFICADA POR @ChumoGH . . . ${c_default}" | pv -qL 20
  [[ ! -d ${IVAR} ]] && touch ${IVAR}
  [[ -d /etc/SCRIPT ]] && rm -rf /etc/SCRIPT/* || mkdir /etc/SCRIPT
  [[ -d /etc/LTM ]] && rm -rf /etc/LTM/* || mkdir /etc/LTM
  [[ -d /bin/ejecutar ]] && rm -f /bin/ejecutar/echo-ram.sh || mkdir /bin/ejecutar
  [[ ! -d /var/www/html/ChumoGH ]] && mkdir /var/www/html/ChumoGH
  atualiza_fun # Descarga y mueve scripts ChumoGH
  msg -bar
  echo -e " RUTAS LATAM "
  msg -bar
  atualiza_funLTM # Descarga y mueve scripts LATAM
  # Configura y ejecuta echo-ram.sh
  echo 'source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/main/back/free-men.sh)' > /bin/ejecutar/echo-ram.sh
  echo '1' >> /bin/ejecutar/echo-ram.sh
  echo 'wget -q -O /bin/ejecutar/v-new.log https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/HTools/AFK/v-new.log' >> /bin/ejecutar/echo-ram.sh
  chmod +x /bin/ejecutar/echo-ram.sh && bash /bin/ejecutar/echo-ram.sh
  echo 1 > /bin/ejecutar/vG-local.log
  # ATENCIÓN: Este es un enlace remoto. En tu control, cámbialo a tu propio repositorio.
  wget --no-check-certificate -q -O /var/www/html/index.html https://www.dropbox.com/s/vowqcezrtiduh8n/index.html

  echo -e "${c_yellow} Perfecto, utilice el comando ${c_red}kcgh ${c_yellow}para administrar sus keys y
 actualizar la base del servidor${c_default}"
  echo -e "${c_cyan}--------------------------------------------------------------------${c_default}"
  echo -e " Recuerda Generar 1 Key manual, luego de terminar la Instalacion "
  echo -e "${c_cyan}--------------------------------------------------------------------${c_default}"
  echo -e "${c_yellow}Key ACCESIBLE MEDIANTE ${PAM}${c_default}" # Aquí $PAM sería '--ADMcgh'
  echo -e "${c_cyan}--------------------------------------------------------------------${c_default}"

  # Mensaje a Telegram (ATENCIÓN: Token hardcodeado)
  _hora=$(date +"%H:%M:%S")
  MENSAJE="••••📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩••••\n"
  MENSAJE+=" IP : $(wget -qO- ifconfig.me)\n"
  MENSAJE+=" INTENTO EXITOSO!! \n"
  MENSAJE+=" �️: ${keybot} > $1 \n" # $keybot no está definido aquí, sería null
  MENSAJE+=" ••••••••••••••••••••••••••••••••••••••••••••••••\n"
  MENSAJE+=" IP : ${IP} HORA : ${_hora}\n"
  MENSAJE+=" ••••••••••••••••••••••••••••••••••••••••••••••••\n"
  MENSAJE+='       🔰 Bot generador de key 🔰\n'
  MENSAJE+='           ⚜ By @ChumoGH ⚜ \n'
  MENSAJE+=" ••••••••••••••••••••••••••••••••••••••••••••••••\n"
  TOKEN='1835793685:AAETvw5c4fF4fhUIconDQK5QyjXC-Ub2L74' # TOKEN hardcodeado
  ID=$(echo $TOKEN | awk '{print $2}') # ID extraído, pero no hay ID en ese token
  urlBOT="https://api.telegram.org/bot$TOKEN/sendMessage"
  curl -s --max-time 10 -d "chat_id=$ID&disable_web_page_preview=1&text=$(echo -e "$MENSAJE")" "$urlBOT" &>/dev/null

  echo -e 'POR SEGURIDAD DEL FILTRO HTTP sin TLS DIGITA ESTO FUERA DEL SCRITP '
  echo -e ""
  echo -e ' bash -c "$(curl -fsSL https://www.dropbox.com/s/bvnobv1atoj9pgw/fai2ban.sh)" --BOT '
  echo -e ""

else
  # Si no se pasa el argumento '--ADMcgh', esto es una condición de salida del script original
  # o la lógica de "verificación" sin instalación completa.
  echo -e "${c_red} ERROR: Parámetro de instalación no especificado.${c_default}"
  echo -e "${c_red} Uso: sudo bash setup --ADMcgh${c_default}"
  rm -f setup*
  rm -f ADm*
  exit 1
fi

# Marcador de instalación (contador)
[[ ! -e /etc/http-instas ]] && echo '0' > /etc/http-instas || let sd=$(cat < /etc/http-instas)-$coo && echo $sd > /etc/http-instas
[[ -d $SCPT_DIR ]] && rm -rf $SCPT_DIR # Esto parece un error, borra el propio directorio de scripts

echo "$(wget -qO- ifconfig.me)" > /etc/key-gerador
echo -ne "${c_default}"
rm -f setup*
rm -f ADm*

�