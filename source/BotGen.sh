#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#https://github.com/joao-lucas/ShellBot

CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
CIDimg=/etc/tokenIMG && [[ ! -d ${CIDimg} ]] && mkdir ${CIDimg}
SRC="${CIDdir}/sources" && [[ ! -d ${SRC} ]] && mkdir ${SRC}
CID="${CIDdir}/User-ID" && [[ ! -e ${CID} ]] && echo > ${CID}
keytxt="${CIDdir}/keys" && [[ ! -d ${keytxt} ]] && mkdir ${keytxt}
timg="${CIDimg}/img" && [[ ! -d ${timg} ]] && mkdir ${timg}
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
#[[ ! -e "/bin/ShellBot.sh" ]] && wget -O /bin/ShellBot.sh https://www.dropbox.com/s/iyce2b0e180wynr/ShellBot.sh &> /dev/null
[[ ! -e "/bin/ShellBot.sh" ]] && wget -O /bin/ShellBot.sh https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/ShellBot/ShellBot.sh &> /dev/null
[[ -e /etc/texto-bot ]] && rm /etc/texto-bot
LINE=" ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••" 
[[ ! -e /etc/urlCT ]] && echo "" > /etc/urlCT
[[ ! -e /etc/urlDN ]] && echo "" > /etc/urlDN
_fecha=`date +%d-%m-%y`
#_hora=$(printf '%(%D-%H:%M:%S)T') 
_hora=$(date +"%H:%M:%S") 
source <(curl -sSL https://raw.githubusercontent.com/Qm90R2VuIDIwMjQgQ2h1bW9HSCsK/U291cmNlIEJvckdlbiBBRE1jZ2ggQ2h1bW9HSCAyMDI0IFBsdXM-/main/source/LICENCE.crt) 
_globales=$(curl -sSL "https://raw.githubusercontent.com/SNIPER754186/chumonewbot/refs/heads/LaTamSRC/source/Control-Bot.txt" | cut -d '|' -f1)


# Importando API
source ShellBot.sh

call.barras(){
local _sim=$1
local _col=$2
	for (( i = 0; i < ${_col}; i++ )); do
		echo -ne "${_sim}"
	done
}


[[ -e ${SRC}/menu ]] && source ${SRC}/menu
[[ -e ${SRC}/ayuda ]] && source ${SRC}/ayuda
[[ -e ${SRC}/cache ]] && source ${SRC}/cache
[[ -e ${SRC}/invalido ]] && source ${SRC}/invalido
[[ -e ${SRC}/status ]] && source ${SRC}/status
[[ -e ${SRC}/reinicio ]] && source ${SRC}/reinicio
[[ -e /bin/ejecutar/IPcgh ]] && _myIP=$(cat < /bin/ejecutar/IPcgh)
[[ -e ${SRC}/id ]] && source ${SRC}/id
[[ -e ${SRC}/back_ID ]] && source ${SRC}/back_ID
[[ -e ${SRC}/link ]] && source ${SRC}/link
[[ -e ${SRC}/listID ]] && source ${SRC}/listID
[[ -e ${SRC}/gerar_key ]] && source ${SRC}/gerar_key
[[ -e ${SRC}/power ]] && source ${SRC}/power
[[ -e ${SRC}/comandos ]] && source ${SRC}/comandos
[[ -e ${SRC}/donar ]] && source ${SRC}/donar
[[ -e ${SRC}/costes ]] && source ${SRC}/costes
#source ${SRC}/kill_drop.sh
titulosC='Bienvenido al BotGen ADMcgh/Plus'
# Token del bot
bot_token="$(cat ${CIDdir}/token)"

# Inicializando el bot
ShellBot.init --token "$bot_token" --monitor --flush --return map
ShellBot.username


_killID(){
if [[ ! -e /etc/systemd/system/btkill.service ]]; then
wget -O /etc/ADM-db/sources/kill_drop.sh https://raw.githubusercontent.com/Qm90R2VuIDIwMjQgQ2h1bW9HSCsK/U291cmNlIEJvckdlbiBBRE1jZ2ggQ2h1bW9HSCAyMDI0IFBsdXM-/main/init.M/kill_drop.sh

[[ -e /etc/ADM-db/sources/kill_drop.sh  ]] && chmod +x /etc/ADM-db/sources/kill_drop.sh 
local MSG_id=$((${message_message_id} + 1 ))
echo -e "[Unit]
Description=BotGen Service by @ChumoGH
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/bin/bash /etc/ADM-db/sources/kill_drop.sh 
Restart=always
RestartSec=60s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/btkill.service
systemctl daemon-reload &>/dev/null
systemctl enable btkill &>/dev/null
systemctl start btkill &>/dev/null
local bot_retorno="  ✉️ ====== NOTIFICACION ====== ✉️ \n"
bot_retorno+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
bot_retorno+=" KILL ID : <u>ACTIVADO</u> ✅\n"
bot_retorno+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
ShellBot.sendMessage	--chat_id ${permited} \
						--text "<i>$(echo -e $bot_retorno)</i>" \
						--parse_mode html 
sleep 2s
msj_del ${message_message_id}
msj_del ${MSG_id}
else
killall kill_drop.sh &>/dev/null
systemctl daemon-reload &>/dev/null
systemctl stop btkill &>/dev/null
systemctl disable btkill &>/dev/null
rm /etc/systemd/system/btkill.service &>/dev/null
local MSG_id=$((${message_message_id} + 1 ))
[[ -z ${callback_query_from_username} ]] && nUSER=${message_from_username} || nUSER=${callback_query_from_username}
local bot_retorno="  ✉️ ====== NOTIFICACION ====== ✉️ \n"
bot_retorno+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
bot_retorno+=" KILL ID : <u>DESCATIVADO</u> ❌\n"
bot_retorno+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
ShellBot.sendMessage	--chat_id ${permited} \
						--text "<i>$(echo -e $bot_retorno)</i>" \
						--parse_mode html 
sleep 2s
msj_del ${message_message_id}
msj_del ${MSG_id}
fi
}


reply () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}

		 	 ShellBot.sendMessage	--chat_id  $var \
									--text "$comando" \
									--parse_mode html \
									--reply_markup "$(ShellBot.ForceReply)"
	[[ "${callback_query_data}" = /del || "${message_text}" = /del ]] && listID_src
	[[ "${callback_query_data}" = /add || "${message_text}" = /add ]] && call.add
	#[[ "${callback_query_data}" = /img || "${message_text}" = /img ]] && listID_src
	[[ "${callback_query_data}" = '/banIP' || "${message_text}" = '/banIP' ]] && list_IP
	[[ "${callback_query_data}" = '/folteto' || "${message_text}" = '/folteto' ]] && dupdate2
	[[ "${callback_query_data}" = '/CPrecios' || "${message_text}" = '/CPrecios' ]] && call.MPrecios
	[[ "${callback_query_data}" = /cupon || "${message_text}" = /cupon ]] && call.cupon
	[[ "${callback_query_data}" = /notify || "${message_text}" = /notify ]] && call.notify
	[[ "${callback_query_data}" = /ccupon || "${message_text}" = /ccupon ]] && call.CREARcupon
	[[ "${callback_query_data}" = /cfj || "${message_text}" = /cfj ]] && call.CREARcuponFJ
	[[ "${callback_query_data}" = /domainA || "${message_text}" = /domainA || "${callback_query_data}" = /domaina || "${message_text}" = /domaina ]] && call.domain
	[[ "${callback_query_data}" = /chat || "${message_text}" = /chat ]] && call.msgUSER
	[[ "${callback_query_data}" = /domainNS || "${message_text}" = /domainNS || "${callback_query_data}" = /domainns || "${message_text}" = /domainns ]] && call.domainB
	[[ "${callback_query_data}" = /upfile || "${message_text}" = /upfile ]] && call.mssFAC 
	[[ "${callback_query_data}" = /remote || "${message_text}" = /remote ]] && call.RMT 
	[[ "${callback_query_data}" = /kid || "${message_text}" = /kid ]] && _killID
	
}

call.notify(){
local bot_retorno="=================================\n"
      bot_retorno+=" Envia tu SMS o Replica!! \n"
      bot_retorno+="=================================\n"
msj_fun
}

call.notify.send(){
local MENSAJE=$(echo -e "${message_text[$id]}")
local urlBOT="https://api.telegram.org/bot$TOKEN/sendMessage"
MENSAJE+="\n ================================= \n"
MENSAJE+="\n   💥 POWER BY @${_ress} 💥 \n"
MENSAJE+="\n ================================= \n"
#MENSAJE+='&reply_markup={"inline_keyboard":[[{"text":"NEW KEY","callback_data":"/keygen"},{"text":" SOPORTE ","url":"https://t.me/ChumoGH_ADM"}]]}'
# Verificar si el CID existe y es legible
if [ ! -f "$CID" ]; then
    echo "El archivo '$CID' no existe o no es accesible."
    exit 1
fi
# Procesar cada línea del archivo
contador=1
while IFS= read -r linea || [ -n "$linea" ]; do
    # Extraer el ID de la primera columna usando `awk` y `cut`
    ID=$(echo "$linea" | awk -F '|' '{gsub("[^0-9]", "", $1); print $1}')
    # Imprimir el ID en el formato deseado
    echo "El $contador ID es $ID"
	#curl -s --max-time 10 -d "chat_id=$ID&disable_web_page_preview=1&text=$(echo -e "$MENSAJE")" ${urlBOT} &>/dev/null
#	ShellBot.sendMessage 	--chat_id "$ID" \
#										--text "<i>$(echo -e "$MENSAJE")</i>" \
#										--parse_mode html 
	msj_add "${ID}" "${MENSAJE}"
	echo -e "MENSAJE A $ID ENVIADO"
	sleep 0.5s
    # Incrementar el contador
    ((contador++))
done < "$CID"
#ShellBot.deleteMessage  --chat_id ${return[chat_id]} --message_id "${return[message_id]}"
ShellBot.sendMessage 	--chat_id "$(cat < ${CIDdir}/Admin-ID)" \
										--text "<i>$(echo -e "MENSAJE ENVIADO A $contador USUARIOS")</i>" \
										--parse_mode html 
return
}

call.cambio_precios(){
#my_ip=$(echo ${message_text[$id]} | cut -d "|" -f1)
#opcion=$(echo ${message_text[$id]} | cut -d "|" -f2)
#name=$(echo ${message_text[$id]} | cut -d "|" -f3)
[[ -z ${message_text[$id]} ]] && _urlC='https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/costos' || _urlC="${message_text[$id]}"
precios=$(curl -sSL "${_urlC}")
[[ -z ${precios} ]] && precios=$(curl -sSL "https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/costos")
echo -e "${_urlC}" > /etc/ADM-db/costos.url
chmod +x /etc/ADM-db/costos.url
_NPrecios="  ⚠️ PRECIOS ALTERADOS!!! ⚠️\n"
_NPrecios="  ⚠️ PRECIOS ALTERADOS!!! ⚠️\n"
ShellBot.sendMessage 	--chat_id "$(cat < ${CIDdir}/Admin-ID)" \
										--text "<i>$(echo -e ${_NPrecios})</i>" \
										--parse_mode html 
prices_on
}

call.file(){


ShellBot.sendDocument --chat_id ${message_chat_id[$id]} \
                             --document @$HOME/payloads.txt
}


fun_kfree () {
	rm /etc/SCRIPT/*.x.c &> /dev/null
	unset KEY
	KEY="$1"
	#CRIA DIR
	[[ ! -e ${DIR} ]] && mkdir ${DIR}
	#CRIA KEY
	[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
	#PASSA ARQS
	nombrevalue="${chatuser}"
	#ADM BASIC
	arqslist="$(ls /etc/SCRIPT/)"
	for arqx in `echo "${arqslist}"`; do
		[[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
		cp ${scriptDIR}/$2/$arqx ${DIR}/${KEY}/
		echo "$arqx" >> ${DIR}/${KEY}/${LIST}
	done
	echo "$nombrevalue" > ${DIR}/${KEY}.name
	[[ ! -z $IPFIX ]] && echo "$IPFIX" > ${DIR}/${KEY}/keyfixa

	if [[ $2 -gt '0' ]]; then
		at now +$2 hours <<< "rm -rf ${DIR}/${KEY} && rm -rf ${DIR}/${KEY}.name"
	fi
}

kads() {
validKF=2
[[ -z ${callback_query_from_username} ]] && usrLOP=${message_from_username} || usrLOP=${callback_query_from_username}
[[ -z ${usrLOP} ]] && {
	local error="=================================\n"
		error+=" Estimado Usuario, imposible permitirle\n"
		error+=" crear una Key sin un ALIAS.\n"
		error+=" Su ID : ${chatuser} REGISTRADO !!\n"
		error+=" ADQUIERE UN ACCESO 🛒🛍️ PINCHANDO 👉<a href='https://shoppy.gg/@ChumoGH/'>AQUI</a>👈 \n"
		error+=" Validado en @$(ShellBot.username)\n"
		error+="=================================\n"
msj_add "${chatuser}" "${error}"
return
}
[[ ${validKF} = 0 ]] && {
	local error="=================================\n"
		error+=" Estimado Usuario, ESTA FUNCION FUE REMOVIDA\n"
		error+=" VERIFICA CON UN ADMINISTRADOR CON\n"
		error+=" SU ID : ${chatuser} REGISTRADO !!\n"
		error+=" ADQUIERE UN ACCESO 🛒🛍️ PINCHANDO 👉<a href='https://shoppy.gg/@ChumoGH/'>AQUI</a>👈 \n"
		error+=" Validado en @$(ShellBot.username)\n"
		error+="=================================\n"
msj_add "${chatuser}" "${error}"
return
}
local chuliss="=================================\n"
chuliss+=" GENERANDO . . . . . . !!\n Porfavor Espere la respuesta del CHAT\n Registramos esta sesion para validar su KEY"
chuliss+="\n================================= \n"
msj_add "${chatuser}" "${chuliss}"
#[[ ! -e $HOME/RegBOT/free_check ]] && touch $HOME/RegBOT/free_check
unset bot_retor
[[ -z ${_ress} ]] && _ress='ChumoGH'
[[ -e ${SRC}/gerar_key ]] && source ${SRC}/gerar_key
meu_ip_fun
[[ -e $HOME/RegBOT/API1 ]] && tokenAPI=$(cat $HOME/RegBOT/API1) || tokenAPI='7471ad0fab169d252bc4631a8'
[[ -e $HOME/RegBOT/API2 ]] && tokenAPI2=$(cat $HOME/RegBOT/API2) || tokenAPI2='0583bebaf93c2c8978085355f79162871f966ec2'
local _link='https://api.cuty.io/full'
local _link2='https://exe.io/api?'
local _nameADS='FreeKey'
#_ads='www.google.com'
[[ -e $HOME/RegBOT/free_check.txt ]] && _cADS=$(cat $HOME/RegBOT/free_check.txt | grep ${chatuser} | wc -l) || _cADS=1
[[ $_cADS -ge 1 ]] && {
ShellBot.deleteMessage  --chat_id ${return[chat_id]} --message_id "${return[message_id]}"
local _line=1
local _enlaces=''
for _lADS in $(cat $HOME/RegBOT/free_check.txt | grep -w ${chatuser} | cut -d '|' -f2) ; do
 _enlaces+=" ${_line}] - ${_lADS} \n"
 let _line++
done
sleep 2s
local mss_ads="=================================\n"
        mss_ads+=" 🔴《 @${usrLOP} UD YA GENERO ${_cADS} KEY GRATIS 》⚫️\n"
        mss_ads+="=================================\n"
        mss_ads+=" AMA AL PROJIMO COMO A TI MISMO!! \n"
        mss_ads+="=================================\n"
        mss_ads+=" Revisa los Enlaces que se generaron \n Y obten tu key antes que se anulen\n"
		mss_ads+="=================================\n"
        mss_ads+="  ${_enlaces}"
        mss_ads+="=================================\n"
		mss_ads+=" ADQUIERE UN ACCESO 🛒🛍️ PINCHANDO 👉<a href='https://shoppy.gg/@ChumoGH/'>AQUI</a>👈 \n"
        mss_ads+=" SU ID : <code>${chatuser}</code> \n Validado en @$(ShellBot.username)\n"
        mss_ads+="=================================\n"
		mss_ads+="\n   💥 POWER BY @${_ress} 💥 \n"
		mss_ads+="\n================================= \n"
msj_add "${chatuser}" "${mss_ads}"
return
}
[[ $(cat ${CID}|grep "${chatuser}") = "" ]] && {
local valuekey="$(echo $RANDOM | md5sum | head -c 15)"
oUP=${IP}
#fun_kfree "$valuekey" '1' 'FREE'
[[ -e $(cat < $HOME/RegBOT/free_check.txt |grep -w ${chatuser}| cut -d '|' -f3) ]] && {
ShellBot.deleteMessage  --chat_id ${return[chat_id]} --message_id "${return[message_id]}"
local mss_ads="=================================\n"
          mss_ads+=" IMPOSIBLE CREAR NUEVO URL KEY\n"
          mss_ads+="=================================\n"
          mss_ads+=" UD YA TIENE UNA KEY SIN USAR\n"
          mss_ads+="=================================\n"
          mss_ads+=" <u>          NOTA </u>\n"
          mss_ads+="=================================\n"
          mss_ads+=" SOLO ABRE EL ENLAZE, SALTA LOS ADS\n"
          mss_ads+="       Y OBTEN TU KEY GRSTIS\n"
          mss_ads+="=================================\n"
          mss_ads+=" No nos cansemos de hacer el bien\n y a su debido tiempo, cosecharemos \n numerosas bendiciones ( GALATAS 6:9 )\n"
          mss_ads+="=================================\n"
		  mss_ads+=" @${usrLOP}, Click 👉<a href='$(cat < $HOME/RegBOT/free_check.txt |grep -w ${chatuser}| cut -d '|' -f2| tail -1)'>AQUI</a>👈 PARA OBTENER SU KEY\n"
		  mss_ads+=" O COPIE : <code> $(cat < $HOME/RegBOT/free_check.txt |grep -w ${chatuser}| cut -d '|' -f2| tail -1) </code>\n"
		  mss_ads+=" Validado en @$(ShellBot.username)\n"
          #mss_ads+=" Reclame su Key en : ${_ads} \n"
          mss_ads+="=================================\n"
msj_add "${chatuser}" "${mss_ads}"
return
}
fun_list "$valuekey" '1' 'FREE' ' '
local keyfinal="$(ofus "$oUP:8888/${valuekey}/$LIST")"
local _ads="${oUP}:81/ChumoGH/${valuekey}"
[[ -e /dominio.txt ]] && _ads="$(cat < /dominio.txt):81/ChumoGH/${valuekey}.html"
[[ -e $HOME/RegBOT/ADM.reg ]] &&  { 
_banner=$(cat $HOME/RegBOT/ADM.reg) 
} || {
_banner=$(curl -s -X GET "https://t.me/ChumoGH"  -H "Content-Type: application/json" | grep tgme_page_title | cut -d '<' -f3 | cut -d '>' -f2)
echo -e "${_banner}" > $HOME/RegBOT/ADM.reg
}
echo -e "${_banner}" > ${SCPT_DIR}/menu_credito
echo -e "$(cat /etc/ADM-db/Admin-ID|head -1)" >> ${SCPT_DIR}/menu_credito
#ls_ads=$(curl -s -X POST "${_link}?token=${tokenAPI}&url=${_ads}&alias=${_nameADS}" -H "Content-Type: application/json" | jq '.')
ls_ads=$(curl -s -X POST "${_link}?token=${tokenAPI}&url=${_ads}" -H "Content-Type: application/json" | jq '.')
url_short=$(echo $ls_ads | jq -r '.data.short_url')
[[ -z ${url_short} ]] && url_short=null
echo -e "${url_short} | ${_ads}"
[[ "${url_short}" != "null" ]] && {
ls_ads2=$(curl -s -X GET "${_link2}api=${tokenAPI2}&url=${url_short}" -H "Content-Type: application/json" | jq '.')
url_short=$(echo $ls_ads2 | jq -r '.shortenedUrl')
#echo " " > /var/www/html/ChumoGH/${valuekey}
at now +30 minutes <<< "bash $HOME/RegBOT/${valuekey}.sh" 
cat << atnow > $HOME/RegBOT/${valuekey}.sh
rm -f /var/www/html/ChumoGH/${valuekey}.html
rm -f $HOME/RegBOT/${valuekey}.sh
atnow

#>> /var/www/html/ChumoGH/${valuekey}
#echo -e "=================================" >> /var/www/html/ChumoGH/${valuekey}
less << KeyFREE  > /var/www/html/ChumoGH/${valuekey}.html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>ADM - ChumoGH</title>
	<link rel="shortcut icon" href="https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/IMG/icon.ico" />
	<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-1009751037406916"
     crossorigin="anonymous"></script>
</head>
<center>
<br>
<hr>
KEY GRATIS GENERARA EL $(printf '%(%D)T') A LAS $(printf '%(%H:%M:%S)T')
<hr>
${keyfinal}
<hr>
 INSTALADOR OFICIAL $(cat < /etc/SCRIPT/v-local.log)
<hr>
apt update -y; apt upgrade -y; wget -q https://plus.admcgh.site/setup; chmod 777 setup; ./setup --ADMcgh
<hr>
ESTE URL SE ELIMINARA A LAS $(at -l | sort -n | awk '{print $5}' | tail -1)
<hr>
</html>
KeyFREE
local mss_ads="=================================\n"
          mss_ads+=" 🔴《 ${_cADS} KEY  GENERADA 》⚫️\n"
          mss_ads+="=================================\n"
          mss_ads+=" ABRA EL ENLACE ACORTADOR DE ABAJO \n SALTA LA PUBLICIDAD Y OBTEN TU KEY GRATIS\n"
          mss_ads+="=================================\n"
          mss_ads+=" <u>     ⚜️ NOTA MOTIVACIONAL ⚜️</u>\n"
          mss_ads+="=================================\n"
          mss_ads+=" No nos cansemos de hacer el bien\n y a su debido tiempo, cosecharemos \n numerosas bendiciones ( GALATAS 6:9 )\n"
          mss_ads+=" ENLACE VALIDO POR 30 MINUTOS\n"
          mss_ads+="=================================\n"
		  mss_ads+=" <u>     🔰 NOTA REFERENCIAL 🔰</u>\n"
          mss_ads+="=================================\n"
		  mss_ads+=" SI GENERAS UN ENLACE Y NO LO USAS,\n"
		  mss_ads+=" ⚠️ SERAS BANEADO INMEDIATAMENTE ⚠️\n"
		  mss_ads+="=================================\n"
		  mss_ads+=" @${usrLOP}, Click 👉<a href='${url_short}'>AQUI</a>👈 PARA OBTENER SU KEY\n"
		  mss_ads+=" O COPIE : <code> ${url_short} </code>\n"
		  mss_ads+=" Validado en @$(ShellBot.username)\n"
          #mss_ads+=" Reclame su Key en : ${_ads} \n"
          mss_ads+="=================================\n"
		  [[ -z $(echo $permited|grep "${chatuser}") ]] && {
		  echo -e "${chatuser}|${url_short}|/var/www/html/ChumoGH/${valuekey}|$(at -l | sort -n | awk '{print $1}' | tail -1)" >> $HOME/RegBOT/free_check.txt
		  #echo -e "${chatuser}|${url_short}" >>  
			} || {
		  [[ ${_cADS} -le 1 ]] && echo -e "${chatuser}|${url_short}" >> $HOME/RegBOT/free_check.txt
		  }
} || {
echo "
=================================
ERROR AL GENERAR LA KEY
=================================
" > /var/www/html/ChumoGH/${valuekey}
at now +15 minutes <<< "rm -f /var/www/html/ChumoGH/${valuekey}.html" 
at -l | tail -1  >> /var/www/html/ChumoGH/${valuekey}.html
echo -e "=================================" >> /var/www/html/ChumoGH/${valuekey}.html
local mss_ads="=================================\n"
          mss_ads+=" 🔴《 Hubo un error Interno 》⚫️\n"
          mss_ads+="=================================\n"
          mss_ads+=" PERO SU ENLACE FUE REDIRIGIDO!!\n"
          mss_ads+="=================================\n"
          mss_ads+=" ABRA EL ENLACE ACORTADOR DE ABAJO \n SALTA LA PUBLICIDAD Y OBTEN TU KEY GRATIS\n"
          mss_ads+="=================================\n"
          mss_ads+=" <u>          NOTA </u>\n"
          mss_ads+="=================================\n"
          mss_ads+=" NO GENERES OTRO ENLACE SI NO CANJEASTE EL ANTERIOR\n"
          mss_ads+=" ENLACE VALIDO POR 15 MINUTOS\n"
          mss_ads+=" SOLO ABRE EL ENLACE EN EL NAVEGADOR, SALTA LA PUBLICIDAD\n"
          mss_ads+=" Y E TE ENTREGARA TU KEY TOTALMENTE FREE\n"
		  mss_ads+="=================================\n"
          mss_ads+=" Click 👉<a href='${url_short}'>AQUI</a>👈\n"
		  mss_ads+=" O COPIE : <code> ${url_short} </code>\n"
		  mss_ads+=" Estimado @${usrLOP} , Disfrute su KEY\n"
          #mss_ads+="================================= \n"
          #mss_ads+=" Reclame su Key en : ${_ads} \n"
          mss_ads+="=================================\n"
#echo -e "${chatuser}|${url_short}" >> $HOME/RegBOT/free_check.txt
}
}
mensajeID="${return[message_id]}"
chatID="${return[chat_id]}"
ShellBot.deleteMessage  --chat_id ${return[chat_id]} --message_id "${return[message_id]}"
echo -e " --chat_id ${chatID} --message_id $((${mensajeID} + 1 ))"
[[ -z $(echo $permited|grep "${chatuser}") ]] && {
msj_add "$(cat < ${CIDdir}/Admin-ID)" "${mss_ads}"
}
[[ -z ${_ress} ]] && _ress='ChumoGH'
local bot_retorno="  ========📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩========\n"
	bot_retorno+=" ${mss_ads} "
	bot_retorno+="\n   💥 POWER BY @${_ress} 💥 \n"
	bot_retorno+="\n================================= \n"
msj_fun
}

call.cupon(){
local bot_retorno="=================================\n"
          bot_retorno+=" 🔴《 CANGEO DE CUPON 》⚫️\n"
		  bot_retorno+="=================================\n"
		  bot_retorno+=" FECHA : $(date '+%Y-%m-%d') | HORA $(printf '%(%H:%M:%S)T')\n"
          bot_retorno+="=================================\n"
		  bot_retorno+="   ❒ FIJATE EN LA HORA DEL BOT!!\n"
          bot_retorno+="   ❒ PEGA TU CUPON, SIN ESPACIOS\n"
          bot_retorno+="   ❒ MUESTRA LOS PRECIOS CON /prices\n"
          bot_retorno+="   ❒ CUPONES/ACCESOS CADUCAN A LAS 00:00 DEL BOT\n"
          bot_retorno+="================================= \n"
          bot_retorno+=" EJEMPLO : <code>AdmCGH-xXxX123</code> \n"
          bot_retorno+="=================================\n"
msj_fun
}

call.CUPONES.fijos () {
local item_access=''
[[ -z $1 ]] && id_receptor=${chatuser} || id_receptor=$1
[[ -z $2 ]] || chatbot=$2
[[ -z $3 ]] || 
local no_valid=''
#BOTONES DE TOKEN DE AUTORIZACIONES FIJOS
ShellBot.InlineKeyboardButton --button 'item_access' --line 1 --text '1 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|1"
ShellBot.InlineKeyboardButton --button 'item_access' --line 1 --text '2 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|2"
ShellBot.InlineKeyboardButton --button 'item_access' --line 1 --text '4 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|4"
ShellBot.InlineKeyboardButton --button 'item_access' --line 1 --text '7 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|7"
ShellBot.InlineKeyboardButton --button 'item_access' --line 2 --text '10 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|10"
ShellBot.InlineKeyboardButton --button 'item_access' --line 2 --text '15 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|15"
ShellBot.InlineKeyboardButton --button 'item_access' --line 2 --text '30 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|30"
ShellBot.InlineKeyboardButton --button 'item_access' --line 2 --text '60 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|60"
ShellBot.InlineKeyboardButton --button 'item_access' --line 3 --text '90 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|90"
ShellBot.InlineKeyboardButton --button 'item_access' --line 3 --text '120 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|120"
ShellBot.InlineKeyboardButton --button 'item_access' --line 3 --text '179 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|179"
ShellBot.InlineKeyboardButton --button 'item_access' --line 3 --text '365 DIAS' --callback_data "call.CrearCuponNew ${no_valid}|365"
ShellBot.InlineKeyboardButton --button 'item_access' --line 4 --text 'DIAS CUSTOM' --callback_data "/ccupon"

						ShellBot.sendMessage --chat_id ${id_receptor} \
							--text "<i>$(echo -e "$chatbot")</i>" \
							--parse_mode html \
							--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'item_access')"
}


call.CREARcupon(){
local bot_retorno="=================================\n"
          bot_retorno+=" 🔴《 CREAR NUEVO CUPON STANDAR  》⚫️\n"
          bot_retorno+="=================================\n"
          bot_retorno+="   ❒ CREA CODIGO DE CUPON, SIN ESPACIOS\n"
          bot_retorno+="   ❒ AÑADE : codigo|tiempo|dueño|false\n"
          bot_retorno+="\n━━━━━━━|[ 🦁 ]|━━━━━━━ \n"
          bot_retorno+=" EJEMPLO : <code>AdmCGH123|2|ChumoGH|false</code> \n"
          bot_retorno+="\n━━━━━━━|[ 🦁 ]|━━━━━━━ \n"
          bot_retorno+="    RECUERDA NO ESPACIOS \n"
msj_fun
}

call.CREARcuponFJ(){
local bot_retorno="=================================\n"
          bot_retorno+=" 🔴《 CREAR NUEVO CUPON FIJO  》⚫️\n"
          bot_retorno+="=================================\n"
		  call.CUPONES.fijos "$(cat < ${CIDdir}/Admin-ID)" "${bot_retor}" "${id_solicitante}"
msj_fun
}


call.CrearCuponNew(){
[[ ${chatuser} = $(cat < ${CIDdir}/Admin-ID) ]] && {
cupon=$(echo ${message_text[$id]} | cut -d "|" -f1)
[[ ${#cupon} -gt 6 ]] || unset cupon
[[ -z ${cupon} ]] && cupon=$(echo $RANDOM | md5sum | head -c 15)
tm=$(echo ${message_text[$id]} |  cut -d "|" -f2)
[[ -z ${tm} ]] && tm='1'
rg=$(echo ${message_text[$id]} | cut -d "|" -f3)
[[ -z ${rg} ]] && rg='ChumoGH'
mb=$(echo ${message_text[$id]} | cut -d "|" -f4)
[[ -z ${mb} ]] && mb=false
echo -e "${cupon}|${tm}|${rg}|${mb}" >> /root/RegBOT/cupones
mssg="  ====================================\n"
mssg+="  🔰 CUPON AÑADIDO CREADO EXITOSAMENTE 🔰 \n"
mssg+="  ====================================\n"
mssg+=" Creado el $(date '+%Y-%m-%d') a las $(printf '%(%H:%M:%S)T') Horas\n"
mssg+="  ====================================\n"
mssg+="       CUPON VALIDO POR ${tm} DIAS \n"
[[ ${mb} = true ]] && mssg+="      SU MEMBRESIA DUAL ESTA ACTIVADA \n"
mssg+=" PARA CANJEARLO DIRIGETE A @$(ShellBot.username)\n"
mssg+="       ESCRIBE EL COMANDO /cupon  \n"
mssg+="     Y LEE LAS INSTRUCCIONES DEL BOT  \n"
mssg+="  ====================================\n"
mssg+=" O PEGA <code>/rcupon ${cupon}</code>  \n"
mssg+="  ====================================\n"
mssg+="  ⚠️ SU CUPON 👉🏻<code>${cupon}</code>👈🏿\n"
mssg+="  ====================================\n"
} || {
mssg="  ====================================\n"
mssg+="  FUNCION SOLO CREADA PARA EL ADMIN !!\n"
mssg+="  ====================================\n"
}
ShellBot.sendMessage 	--chat_id "${chatuser}" \
										--text "<i>$(echo -e ${mssg})</i>" \
										--parse_mode html 
}

call.cange.cupon(){
unset _cupon _lista _code _date _ress _tru nombrevalue usrLOP firsnme lastnme
[[ -z ${nombrevalue} ]] && nombrevalue="${message_from_id}" 
[[ -z ${nombrevalue} ]] && nombrevalue="${callback_query_from_id}"
[[ -z ${callback_query_from_username} ]] && usrLOP=${message_from_username} || usrLOP=${callback_query_from_username}
[[ -z ${callback_query_from_first_name} ]] && firsnme="${message_from_first_name}" || firsnme="${callback_query_from_first_name}"
[[ -z ${callback_query_from_last_name} ]] && lastnme="${message_from_last_name}" || lastnme="${callback_query_from_last_name}"
#my_ip=$(echo ${message_text[$id]} | cut -d "|" -f1)
#opcion=$(echo ${message_text[$id]} | cut -d "|" -f2)
#name=$(echo ${message_text[$id]} | cut -d "|" -f3)
_cupon="${message_text[$id]}"

[[ $(cat /root/RegBOT/banID | grep -w ${nombrevalue}) ]] && {
				bot_retorno=" =============================================\n"
				bot_retorno+=" SU ID FUE BANEADO $(date '+%C%y-%m-%d') - $(date +%R) !! Contacta con $(cat < /etc/ADM-db/resell)!! \n"
				bot_retorno+=" =============================================\n"
				ShellBot.sendMessage 	--chat_id "${nombrevalue}" \
										--text "<i>$(echo -e ${bot_retorno})</i>" \
										--parse_mode html 
				return
}
[[ ${#_cupon} -gt 6 ]] && {
[[ -z ${usrLOP} ]] && {
	local m_fail="  ========📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩========\n"
		m_fail+="  ❌ DESAFORTUNADAMENTE NO POSEES UN ALIAS ! ❌\n"
		m_fail+="  ❌ DIRIJETE A AJUSTES Y AÑADE NOMBRE DE USUARIO ❌\n"
		m_fail+="  🛡️ SU ID : ${nombrevalue} NO REFLEJA SU ALIAS\n"
		m_fail+="  ⚠️ EL CUPON <code>${_cupon}</code> NO PUEDE SER CANJEDO !\n"
		m_fail+="  🗃️ AÑADE UN ALIAS Y REINTENTA NUEVAMENTE!\n"
		m_fail+="  ❌ ID NO REGISTRADO ❌\n"
		ShellBot.sendMessage 	--chat_id "${permited}" \
								--reply_to_message_id "${message_message_id[$id]}" \
								--text "<i>$(echo -e ${m_fail})</i>" \
								--parse_mode html 
		ShellBot.sendMessage 	--chat_id "${nombrevalue}" \
								--reply_to_message_id "${message_message_id[$id]}" \
								--text "<i>$(echo -e ${m_fail})</i>" \
								--parse_mode html 

return
}
_lista=$(cat /root/RegBOT/cupones | grep -w "${_cupon}")
[[ ! -z ${_lista} ]] && {
_code=$(echo -e "${_lista}" | cut -d '|' -f1)
_date=$(echo -e "${_lista}" | cut -d '|' -f2)
_ress=$(echo -e "${_lista}" | cut -d '|' -f3)
_tru=$(echo -e "${_lista}" | cut -d '|' -f4)
sed -i "/${_code}/d" /root/RegBOT/cupones
#sed -i "/${_code}/d" /var/www/html/cupones
local valid=$(date '+%C%y-%m-%d' -d " +${_date} days")
[[ -z $_tru ]] && _tru='false'
		c_cupon="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
		c_cupon+=" 🎊 GRACIAS POR PREFERIRNOS @${usrLOP} 🎊\n"
		#c_cupon+=" 📥 CUPON CANJEADO EXITOSAMENTE! 🎉\n"
		c_cupon+=" EL CUPON VERIFICO ${_date} DIAS -1 ACTUAL! 🐲\n"
		c_cupon+=" 🎄 CODIGO : <code>${_cupon}</code> RETIRADO DE CATALOGO!\n"
		c_cupon+=" ✨ FECHA DE REGISTRO : $(date '+%C%y-%m-%d')|$(date +%R) \n 📆 VALIDO HASTA : ${valid} | 00:00\n"
[[ ${_date} < 2 ]] && {
c_cupon+=" RECOMPENZA 1+ EXTRA EN TIMEZONE $(printf '%(%H:%M:%S)T') \n"
_date=2
valid=$(date '+%C%y-%m-%d' -d " +${_date} days")
}
		if sed -i "/${nombrevalue}/d" $HOME/RegBOT/banID; then 
		c_cupon+=" ✨ SU ID DESBANEADO EXITOSAMENTE ✨\n"
		fi
		  c_cupon+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
          c_cupon+=" SU RESELLER : ${firsnme} ${lastnm} \n"
          c_cupon+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
		  c_cupon+=" 🆔 : ${nombrevalue} | 🔐 ACEPTADO 🧾\n"
		  c_cupon+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
		  c_cupon+=" MEMBRESIA DUALGEN EN : ${_tru}\n"
          c_cupon+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
          c_cupon+=" GENERAR Key's ChumoGH /keygen\n"
          c_cupon+=" GENERAR Key's LATAM   /kltm\n"
          c_cupon+=" DOMINIO CloudFlare /domainA /domainNS\n"
          c_cupon+=" Para MENU Digita el comando /menu\n"
          c_cupon+=" INSTALAR SCRIPT REMOTO /remote\n"
          c_cupon+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
		[[ $(cat ${CID}|grep "${nombrevalue}") = "" ]] && {
		echo "/${nombrevalue} | $valid | ${_tru}" >> ${CID}
		echo "${_code} | ${nombrevalue} | $valid | ${_tru} | @${usrLOP} | ${_cupon}" >> /root/RegBOT/cupon.done
		#cp ${CID} $HOME/
		#backup_file $HOME/User-ID " RESPALDO DE $(cat /etc/ADM-db/resell) "
		#rm $HOME/User-ID
        echo "/${nombrevalue} | $(date '+%C%y-%m-%d') | $(date +%R)" >> $HOME/RegBOT/${nombrevalue}.reg
		[[ -e $HOME/RegBOT/banID ]] && sed -i "/${nombrevalue}/d" $HOME/RegBOT/banID
		[[ -e $HOME/RegBOT/U_check.txt ]] && sed -i "/${nombrevalue}/d" $HOME/RegBOT/U_check.txt
		[[ -e $HOME/RegBOT/killID.log ]] && sed -i "/${nombrevalue}/d" $HOME/RegBOT/killID.log
		_ca=1
		local _env_back=1
		} || {
		echo -e "AQUI SE VALIDARA EL ACUMULATIVO DE DIAS"
		}
		} || {
		[[ -z $(cat < /root/RegBOT/cupon.done| grep -w "${_cupon}") ]] && c_cupon="  ❌ DESAFORTUNADAMENTE EL CUPON NO EXISTE! ❌\n" || c_cupon="  ❌ MUY TARDE, EL CUPON YA FUE CANJEADO! ❌\n"
		c_cupon+="  🛡️ ID : ${nombrevalue}, INTENTO : $(cat </root/RegBOT/U_check.txt|grep -w ${nombrevalue}|wc -l) USER 🙎🏿‍♂️:@${usrLOP}\n"
		[[ -z $(cat < /root/RegBOT/cupon.done| grep -w "${_cupon}") ]] && c_cupon+="  ⚠️ <code>${_cupon}</code> NO EXISTE EN LA LISTA DE CUPONES !\n" || c_cupon+="  ⚠️ CUPON <code>${_cupon}</code> LO CANJEO $(cat < /root/RegBOT/cupon.done| grep -w "${_cupon}" | cut -d '|' -f5) !\n"
		c_cupon+="  🗃️ SOLICITA UN CUPON VALIDO O UNO NUEVO!\n"
		c_cupon+="  ❌ ID NO REGISTRADO, ACCESO NO LIBERADO ❌\n"
		echo "${nombrevalue}" >> /root/RegBOT/U_check.txt
		_ca=0
}
ShellBot.sendMessage 	--chat_id "$(cat < ${CIDdir}/Admin-ID)" \
										--text "<i>$(echo -e ${c_cupon})</i>" \
										--parse_mode html 
									
[[ $_env_back = 1 ]] && {
call.file2 "${CID}" " CUPON CANJEADO POR @${usrLOP} \n ID : ${nombrevalue} con ${_date} DIAS \n BACKUP FILE $(date '+%C%y-%m-%d')"
echo -e "\n\n ============================\n\n"
echo -e "\n EJECUTANDO RECIVIITOOOO . . . . \n"
echo -e "\n\n ============================\n\n"
bash /etc/ADM-db/sources/factura.sh "@${usrLOP}" "${_date}" "${_cupon}" "0.00" "BotGen Generador Premium ${_date} Dias"
sleep 3s
[[ -e /etc/ADM-db/sources/factura.pdf ]] && call.recivo "/etc/ADM-db/sources/factura.pdf" " ESTIMADO @${usrLOP}, SU RECIVO DE SU CANJE!! "
rm -f /etc/ADM-db/sources/factura.pdf
}
_env_back=0
[[ -z ${_ress} ]] && _ress='ChumoGH'
local bot_retorno="  ========📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩========\n"
	bot_retorno+=" ${c_cupon} "
	bot_retorno+=" ================================= \n"
	[[ ${_ca} = 1 ]] && bot_retorno+=" NO OLVIDES ENVIAR CAPTURA AL ADMIN! \n"
	[[ ${_ca} = 1 ]] && bot_retorno+=" ================================= \n"
	bot_retorno+="\n   💥 POWER BY @${_ress} 💥 \n"
	bot_retorno+="\n ================================= \n"
msj_fun
} || {
				bot_retorno=" =============================================\n"
				bot_retorno+=" EL CUPON DEBE MANTENER UN FORMATO ESTANDAR!! \n ID REGISTRADO PARA POSIBLE BANEO \n"
				bot_retorno+=" =============================================\n"
				call.error ${bot_retorno} ${nombrevalue}
}
}

call.cange.cuponC(){
unset _cupon _lista _code _date _ress _tru nombrevalue usrLOP firsnme lastnme
[[ -z ${nombrevalue} ]] && nombrevalue="${message_from_id}" 
[[ -z ${nombrevalue} ]] && nombrevalue="${callback_query_from_id}"
[[ -z ${callback_query_from_username} ]] && usrLOP=${message_from_username} || usrLOP=${callback_query_from_username}
[[ -z ${callback_query_from_first_name} ]] && firsnme="${message_from_first_name}" || firsnme="${callback_query_from_first_name}"
[[ -z ${callback_query_from_last_name} ]] && lastnme="${message_from_last_name}" || lastnme="${callback_query_from_last_name}"
#my_ip=$(echo ${message_text[$id]} | cut -d "|" -f1)
#opcion=$(echo ${message_text[$id]} | cut -d "|" -f2)
#name=$(echo ${message_text[$id]} | cut -d "|" -f3)
#_cupon="${message_text[$id]}"
_cupon="$1"

[[ $(cat /root/RegBOT/banID | grep -w ${nombrevalue}) ]] && {
				bot_retorno=" =============================================\n"
				bot_retorno+=" SU ID FUE BANEADO $(date '+%C%y-%m-%d') - $(date +%R) !! Contacta con $(cat < /etc/ADM-db/resell)!! \n"
				bot_retorno+=" =============================================\n"
				ShellBot.sendMessage 	--chat_id "${nombrevalue}" \
										--text "<i>$(echo -e ${bot_retorno})</i>" \
										--parse_mode html 
				return
}
[[ ${#_cupon} -gt 6 ]] && {
[[ -z ${usrLOP} ]] && {
	local m_fail="  ========📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩========\n"
		m_fail+="  ❌ DESAFORTUNADAMENTE NO POSEES UN ALIAS ! ❌\n"
		m_fail+="  🛡️ ID : ${nombrevalue} SIN ALIAS\n"
		m_fail+="  ⚠️ EL CUPON <code>${_cupon}</code> NO PUEDE SER CANJEDO !\n"
		m_fail+="  🗃️ AÑADE UN ALIAS Y REINTENTA NUEVAMENTE!\n"
		m_fail+="  ❌ ID NO REGISTRADO ❌\n"
		ShellBot.sendMessage 	--chat_id "$(cat < ${CIDdir}/Admin-ID)" \
										--text "<i>$(echo -e ${m_fail})</i>" \
										--parse_mode html 

return
}
_lista=$(cat /root/RegBOT/cupones | grep -w "${_cupon}")
[[ ! -z ${_lista} ]] && {
_code=$(echo -e "${_lista}" | cut -d '|' -f1)
_date=$(echo -e "${_lista}" | cut -d '|' -f2)
_ress=$(echo -e "${_lista}" | cut -d '|' -f3)
_tru=$(echo -e "${_lista}" | cut -d '|' -f4)
sed -i "/${_code}/d" /root/RegBOT/cupones
#sed -i "/${_code}/d" /var/www/html/cupones
valid=$(date '+%C%y-%m-%d' -d " +${_date} days")
[[ -z $_tru ]] && _tru='false'
		c_cupon="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
		c_cupon+=" 🎊 GRACIAS POR PREFERIRNOS @${usrLOP} 🎊\n"
		#c_cupon+=" 📥 CUPON CANJEADO EXITOSAMENTE! 🎉\n"
		c_cupon+=" EL CUPON VERIFICO ${_date} DIAS -1 ACTUAL! 🐲\n"
		c_cupon+=" 🎄 CODIGO : <code>${_cupon}</code> RETIRADO DE CATALOGO!\n"
		c_cupon+=" ✨ FECHA DE REGISTRO : $(date '+%C%y-%m-%d')|$(date +%R) \n 📆 VALIDO HASTA : ${valid} | 00:00\n"
[[ ${_date} < 2 ]] && {
c_cupon+=" RECOMPENZA 1+ EXTRA EN TIMEZONE $(printf '%(%H:%M:%S)T') \n"
_date=2
valid=$(date '+%C%y-%m-%d' -d " +${_date} days")
}
		if sed -i "/${nombrevalue}/d" $HOME/RegBOT/banID; then 
		c_cupon+=" ✨ SU ID DESBANEADO EXITOSAMENTE ✨\n"
		fi
		  c_cupon+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
          c_cupon+=" SU RESELLER : ${firsnme} ${lastnm} \n"
          c_cupon+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
		  c_cupon+=" 🆔 : ${nombrevalue} | 🔐 ACEPTADO 🧾\n"
		  c_cupon+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
		  c_cupon+=" MEMBRESIA DUALGEN EN : ${_tru}\n"
          c_cupon+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
          c_cupon+=" GENERAR Key's ChumoGH /keygen\n"
          c_cupon+=" GENERAR Key's LATAM   /kltm\n"
          c_cupon+=" DOMINIO CloudFlare /domainA /domainNS\n"
          c_cupon+=" Para MENU Digita el comando /menu\n"
          c_cupon+=" INSTALAR SCRIPT REMOTO /remote\n"
          c_cupon+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
		[[ $(cat ${CID}|grep "${nombrevalue}") = "" ]] && {
		echo "/${nombrevalue} | $valid | ${_tru}" >> ${CID}
		echo "${_code} | ${nombrevalue} | $valid | ${_tru} | @${usrLOP} | ${_cupon}" >> /root/RegBOT/cupon.done
        echo "/${nombrevalue} | $(date '+%C%y-%m-%d') | $(date +%R)" >> $HOME/RegBOT/${nombrevalue}.reg
		[[ -e $HOME/RegBOT/banID ]] && sed -i "/${nombrevalue}/d" $HOME/RegBOT/banID
		[[ -e $HOME/RegBOT/U_check.txt ]] && sed -i "/${nombrevalue}/d" $HOME/RegBOT/U_check.txt
		[[ -e $HOME/RegBOT/killID.log ]] && sed -i "/${nombrevalue}/d" $HOME/RegBOT/killID.log
		_ca=1
		local _env_back=1
		}
		} || {
		[[ -z $(cat < /root/RegBOT/cupon.done| grep -w "${_cupon}") ]] && c_cupon="  ❌ DESAFORTUNADAMENTE EL CUPON NO EXISTE! ❌\n" || c_cupon="  ❌ MUY TARDE, EL CUPON YA FUE CANJEADO! ❌\n"
		c_cupon+="  🛡️ ID : ${nombrevalue}, INTENTO : $(cat </root/RegBOT/U_check.txt|grep -w ${nombrevalue}|wc -l) USER 🙎🏿‍♂️:@${usrLOP}\n"
		[[ -z $(cat < /root/RegBOT/cupon.done| grep -w "${_cupon}") ]] && c_cupon+="  ⚠️ <code>${_cupon}</code> NO EXISTE EN LA LISTA DE CUPONES !\n" || c_cupon+="  ⚠️ CUPON <code>${_cupon}</code> LO CANJEO $(cat < /root/RegBOT/cupon.done| grep -w "${_cupon}" | cut -d '|' -f5) !\n"
		c_cupon+="  🗃️ SOLICITA UN CUPON VALIDO O UNO NUEVO!\n"
		c_cupon+="  ❌ ID NO REGISTRADO, ACCESO NO LIBERADO ❌\n"
		echo "${nombrevalue}" >> /root/RegBOT/U_check.txt
		_ca=0
}
ShellBot.sendMessage 	--chat_id "$(cat < ${CIDdir}/Admin-ID)" \
										--text "<i>$(echo -e ${c_cupon})</i>" \
										--parse_mode html 
[[ $_env_back = 1 ]] && {
call.file2 "${CID}" " Respaldo con @${usrLOP} \n ID : ${nombrevalue} / ${_date} DIAS \n BACKUP FILE LIST-ID EL $(date '+%C%y-%m-%d')"
echo -e "\n EJECUTANDO RECIVIITOOOO . . . . \n"
echo -e "\n\n ============================\n\n"
bash /etc/ADM-db/sources/factura.sh "@${usrLOP}" "${_date}" "${_cupon}" "0.00" "BotGen Generador Premium ${_date} Dias"
sleep 3s
[[ -e /etc/ADM-db/sources/factura.pdf ]] && call.recivo "/etc/ADM-db/sources/factura.pdf" " ESTIMADO @${usrLOP}, SU RECIVO DE SU CANJE!! "
rm -f /etc/ADM-db/sources/factura.pdf
}
_env_back=0
[[ -z ${_ress} ]] && _ress='ChumoGH'
local bot_retorno="  ========📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩========\n"
	bot_retorno+=" ${c_cupon} "
	bot_retorno+=" ================================= \n"
	[[ ${_ca} = 1 ]] && bot_retorno+=" NO OLVIDES ENVIAR CAPTURA AL ADMIN! \n"
	[[ ${_ca} = 1 ]] && bot_retorno+=" ================================= \n"
	bot_retorno+="\n   💥 POWER BY @${_ress} 💥 \n"
	bot_retorno+="\n ================================= \n"
msj_fun
} || {
				bot_retorno=" =============================================\n"
				bot_retorno+=" EL CUPON DEBE MANTENER UN FORMATO ESTANDAR!! \n ID REGISTRADO PARA POSIBLE BANEO \n"
				bot_retorno+=" =============================================\n"
				call.error ${bot_retorno} ${nombrevalue}
}
}

call.error () {
				ShellBot.sendMessage 	--chat_id "$2" \
										--text "<i>$(echo -e $1)</i>" \
										--parse_mode html 
return
}

call.MPrecios(){
local bot_retorno="━━━━━━━━《⚫️》━━━━━━━━\n"
          bot_retorno+=" 🔴《 FUNCION CAMBIAR PRECIOS GENERICOS 》⚫️\n"
          bot_retorno+="━━━━━━《🔴》━━━━━━\n"
          bot_retorno+="   ❒ MANTENER PRECISO ESTANDAR\n"
          bot_retorno+="   ❒ ESCRIBIR LA SINTAXIS CORRECTA\n"
          bot_retorno+="   ❒ AGREGA CARACTERES FIGURAS, ETC \n"
          bot_retorno+="   ❒ SUBE EL FICHERO A GitHub/Dropbox \n"
          bot_retorno+="   ❒ EXTRAE EL URL/LINK PUBLICO \n"
          bot_retorno+="   ❒ MUESTRA LOS PRECIOS CON /prices\n"
          bot_retorno+="━━━━━━━|[ 🦁 ]|━━━━━━━ \n\n"
          bot_retorno+=" EJEMPLO : <a href='https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/costos'>AQUI</a>👈 \n"
          bot_retorno+="\n━━━━━━━|[ 🦁 ]|━━━━━━━ \n"
          bot_retorno+="    RECUERDA NO ESPACIOS \n"
msj_fun
}

#==================================================================

call.domain (){
local _n='1'
local bot_retorno="━━━━━━━━《⚫️》━━━━━━━━\n"
          bot_retorno+=" 🔴《 FUNCION DOMINIOS DISPONIBLES 》⚫️\n"
          bot_retorno+="━━━━━━━━《⚫️》━━━━━━━━\n"		  
		  IFS=',' read -ra lista <<< "$_dmi"
		  for _lDOM in ${lista[@]}; do
          bot_retorno+=" ${_n}) ✅ *.${_lDOM}    $(echo -e $_cdu | cut -d ',' -f${_n})\n"
		  let _n++
		  done
          bot_retorno+="━━━━━━《🔴》━━━━━━\n"
          bot_retorno+=" GUIA : 👉<a href='https://youtu.be/1oPXnnoSSGQ'>AQUI</a>👈\n"
          bot_retorno+="━━━━━━《🔴》━━━━━━\n"
          bot_retorno+="   ❒ ESCOGER 1 DOMINIO DISPONIBLES\n"
          bot_retorno+="   ❒ ESCRIBIR LA SINTAXIS CORRECTA\n"
          bot_retorno+="   ❒ D/(DNS) | P/(PROXY)\n"
          bot_retorno+="   ❒ FORMATO : IP|1|nombre|D\n"
          bot_retorno+="   ❒ RESULTADO : nombre.xxxxx.xxx\n"
          bot_retorno+="━━━━━━|[ EJEMPLO ]|━━━━━━ \n\n"
          bot_retorno+=" <code>10.20.5.1|1|ejemplo123|D</code> \n"
          bot_retorno+="\n━━━━━━━|[ 🦁 ]|━━━━━━━ \n"
          bot_retorno+="    RECUERDA NO ESPACIOS \n"
msj_fun
#--call.domainA
#--call.domainNS
}


call.add(){
unset MSG_up
local bot_retorno="━━━━━━━━《⚫️》━━━━━━━━\n"
      bot_retorno+=" ❒ TAB ID A AUTORIZAR <code>${message_message_id}</code> \n"
      bot_retorno+=" ❒ ESCRIBIR LA SINTAXIS CORRECTA\n"
      bot_retorno+=" ❒ FORMATO : ID | dias | false/true\n"
      bot_retorno+=" ❒ FALSE | DualGen No Permitido\n"
      bot_retorno+=" ❒ TRUE  | DualGen Permitido \n"
      bot_retorno+=" ❒ RESULTADO : REGISTRO APROBADO !!\n"
      bot_retorno+="━━━━━━━|[ 🦁 ]|━━━━━━━ \n\n"
      bot_retorno+=" EJEMPLO : <code>X1X2X3X4X5 | 30 | false</code> \n"
      bot_retorno+="\n━━━━━━━|[ 🦁 ]|━━━━━━━ \n"
#MSG_id=$((${message_message_id} - 1 ))
MSG_up="${message_message_id}"
MSG_med=$((${message_message_id} + 1 ))
MSG_down=$((${message_message_id} + 2 ))
msj_fun
}

call.domainB (){
local _n='1'
local bot_retorno="━━━━━━━━《⚫️》━━━━━━━━\n"
          bot_retorno+=" 🔴《 FUNCION DOMINIOS DISPONIBLES 》⚫️\n"
          bot_retorno+="━━━━━━━━《⚫️》━━━━━━━━\n"
		  IFS=',' read -ra lista <<< "$_dmi"
		  for _lDOM in ${lista[@]}; do
          bot_retorno+=" ${_n}) ✅ *.${_lDOM}\n"
		  let _n++
		  done
          bot_retorno+="━━━━━━《🔴》━━━━━━\n"
          bot_retorno+="   ❒ REGISTRO PREVIO DE SubDOMINIO A-@\n"
          bot_retorno+="   ❒ ESCRIBIR LA SINTAXIS CORRECTA\n"
          bot_retorno+="   ❒ FORMATO : domain|NS_nombre\n"
          bot_retorno+="   ❒ RESULTADO : NS_name.domain\n"
          bot_retorno+="━━━━━━━|[ 🦁 ]|━━━━━━━ \n\n"
          bot_retorno+=" EJEMPLO : <code>domain.com|ejemploNS</code> \n"
          bot_retorno+="\n━━━━━━━|[ 🦁 ]|━━━━━━━ \n"
          bot_retorno+="    RECUERDA NO ESPACIOS \n"
msj_fun
#--call.domainA
#--call.domainNS
}

call.domainA (){
my_ip=$(echo ${message_text[$id]} | cut -d "|" -f1)
opcion=$(echo ${message_text[$id]} | cut -d "|" -f2)
name=$(echo ${message_text[$id]} | cut -d "|" -f3)
typeD=$(echo ${message_text[$id]} | cut -d "|" -f4)
[[ -e ${typeD} ]] && typeD='D'
[[ ${typeD} = 'P' ]] && tproxy='true' || tproxy='false'
#-----------------APIS + TOKEN ------------------------
#source <(curl -sL https://raw.githubusercontent.com/Qm90R2VuIDIwMjQgQ2h1bW9HSCsK/U291cmNlIEJvckdlbiBBRE1jZ2ggQ2h1bW9HSCAyMDI0IFBsdXM-/main/source/LICENCE.crt)

case $opcion in
	1)_domain1;;
	2)_domain2;;
	3)_domain3;;
	4)_domain4;;
	5)_domain5;;
	6)_domain6;;
	0)break;;
esac

echo -e $token
echo -e ${_domain}
local bot_retorno="━━━━━━━━━━━━━━━━━━━━━ \n"

	ls_dom=$(curl -s -X GET "$url/$_dns/dns_records?per_page=100" \
     -H "Authorization: Bearer $token" \
     -H "Content-Type: application/json" | jq '.')
	 
    num_line=$(echo $ls_dom | jq '.result | length')
    ls_domi=$(echo $ls_dom | jq -r '.result[].name')
    ls_ip=$(echo $ls_dom | jq -r '.result[].content')
	
	if [[ $(echo "$ls_ip"|grep -w "$my_ip") = "$my_ip" ]];then
		for (( i = 0; i < $num_line; i++ )); do
			if [[ $(echo "$ls_dom" | jq -r ".result[$i].content"|grep -w "$my_ip") = "$my_ip" ]]; then
				domain=$(echo "$ls_dom" | jq -r ".result[$i].name")
				#echo "$domain" > ${ADM_src}/dominio.txt
				echo "$my_ip|$domain|$opcion" >> /root/RegBOT/dominios.log
				break
			fi
		done
		bot_retorno+="  ⚠️ ADVERTENCIA DE ERROR ⚠️\n"
		bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
		bot_retorno+=" YA EXISTE UN IP REGISTRADO \n"
		bot_retorno+=" IP REGISTRADA -> <code>$my_ip</code> 🕸️\n"
		bot_retorno+="      ˅ 🔗 APUNTA A 🔗 ˅ \n"
		bot_retorno+=" Subdominio : 🌎 <code>$domain</code>  \n"
		bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
		msj_fun
		return 0
    fi
var=$(cat <<EOF
{
  "type": "A",
  "name": "$name",
  "content": "$my_ip",
  "ttl": 1,
  "priority": 10,
  "proxied": ${tproxy}
}
EOF
)
    chek_domain=$(curl -s -X POST "$url/$_dns/dns_records" \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    -d $(echo $var|jq -c '.')|jq '.')

    if [[ "$(echo $chek_domain|jq -r '.success')" = "true" ]]; then
    echo "$my_ip|$(echo $chek_domain|jq -r '.result.name')|${opcion}" >> /root/RegBOT/dominios.log
	#echo "$(echo $chek_domain|jq -r '.result.name')" > ${ADM_src}/dominio.txt
	bot_retorno+=" IP REGISTRADA : $my_ip\n"
	bot_retorno+=" ✅ SubDOMINIO A -> @ ACEPTADO ✅\n"
	[[ ${tproxy} = true ]] && bot_retorno+=" SubDomain Proxied Automatico\n" || bot_retorno+=" SubDomain de tipo solo DNS\n"
	bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
	[[ ${tproxy} = true ]] && bot_retorno+="   ❒ Proxied : <code>$(echo $chek_domain|jq -r '.result.name')</code>\n" || bot_retorno+="   ❒ DNS Only : <code>$(echo $chek_domain|jq -r '.result.name')</code>\n"

	bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
	bot_retorno+="RECUERDA SI QUIERES DOMINIO TIPO PROXY \n"
	bot_retorno+=" AÑADE LA P AL FINAL COMO SE MUESTRA EL \n"
	bot_retorno+=" EJEMPLO : <code>${my_ip}|${opcion}|${name}|P</code> \n"
	bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
	bot_retorno+=" FECHA : $(date '+%Y-%m-%d') | HORA $(printf '%(%H:%M:%S)T')\n"
	bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
	[[ ${opcion} -eq 4 || ${opcion} -eq 5 ]] && bot_retorno+=" DOMINIO DONADO POR @HYDRAVPS \n"
	[[ ${opcion} -eq 4 || ${opcion} -eq 5 ]] && bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
    else
		bot_retorno+=" ❎ SubDOMINIO A -> @ RECHAZADO ❎\n"
		bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
        bot_retorno+="   ❒ RESULTADO : ❌ ERROR ❌\n"
		bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
    fi
msj_fun
#--call.domainA
#--call.domainNS
}

call.msgUSER (){
local bot_retorno="━━━━━━━━《⚫️》━━━━━━━━\n"
		bot_retorno+=" 🔴《 MENSAJE DEL ADMINISTRADOR 》⚫️\n"
          bot_retorno+="━━━━━━《🔴》━━━━━━\n"
          bot_retorno+="   ❒ ESCRIBIR LA SINTAXIS CORRECTA\n"
          bot_retorno+="   ❒ FORMATO : MENSAJE XXX|ID\n"
          bot_retorno+="   ❒ PUEDES AÑADIR ESPACIOS Y URLS\n"
          bot_retorno+="   ❒ COLOCA EL <code>|</code> ANTES DEL ID\n"
          bot_retorno+="   ❒ RESULTADO : MENSAJE ENVIADO\n"
          bot_retorno+="━━━━━━━|[ 🦁 ]|━━━━━━━ \n\n"
          bot_retorno+=" EJEMPLO : <code>HOLA QUE TAL|${chatuser}</code> \n"
          bot_retorno+="\n━━━━━━━|[ 🦁 ]|━━━━━━━ \n"
msj_fun
}

call.msgENV() {
mss=$(echo ${message_text[$id]} | cut -d "|" -f1)
idUSR=$(echo ${message_text[$id]} | cut -d "|" -f2)
local bot_retorno="━━━━━━━━《⚫️》━━━━━━━━\n"
		bot_retorno+=" 🔴《 MENSAJE ENVIADO CORRECTAMENTE 》⚫️\n"
		bot_retorno+="━━━━━━━━《⚫️》━━━━━━━━\n"
		bot_retorno+=" ${mss}\n"
		bot_retorno+="━━━━━━━━《⚫️》━━━━━━━━\n"
msj_fun
local bot_retor="━━━━━━━━《⚫️》━━━━━━━━\n"
		bot_retor+=" 🔴《 MENSAJE DEL ADMINISTRADOR 》⚫️\n"
		bot_retor+="━━━━━━━━《⚫️》━━━━━━━━\n"
		bot_retor+="${mss}\n"
		bot_retor+="━━━━━━《⚫️》━━━━━━\n"
		bot_retor+="   💥 Bot ADMcgh GEN de KEY 💥\n"
		bot_retor+="         ⚜ by $(cat < /etc/ADM-db/resell) ⚜\n"
		bot_retor+="━━━━━━《⚫️》━━━━━━\n"
msj_add "${idUSR}"
}

call.RMT() {
MSG_id=$((${message_message_id} + 1 ))
local bot_retorno="━━━━━━━━《⚫️》━━━━━━━━\n"
          bot_retorno+=" 🔴《 FUNCION INSTALAR SCRIPT REMOTO 》⚫️\n"
          bot_retorno+="━━━━━━━━《⚫️》━━━━━━━━\n"
          #bot_retorno+=" 1) ✅ *.chumogh.site\n"
          #bot_retorno+=" 2) ✅ *.chumogh.online\n"
          #bot_retorno+=" 3) ✅ *.antonioyt.online\n"
          #bot_retorno+="━━━━━━《🔴》━━━━━━\n"
          bot_retorno+="   ❒ LEER LAS INDICACIONES \n"
          bot_retorno+="   ❒ COLOCAR CORRECTAMENTE LOS DATOS\n"
          bot_retorno+="   ❒ FORMATO : IP|nombre_user|clave\n"
          bot_retorno+="   ❒ RESULTADO : DONE!!\n"
          bot_retorno+="━━━━━━━|[ 🦁 ]|━━━━━━━ \n\n"
          bot_retorno+=" EJEMPLO : <code>192.168.1.1|root|miclave123</code> \n"
          bot_retorno+="\n━━━━━━━|[ 🦁 ]|━━━━━━━ \n"
          bot_retorno+="    RECUERDA NO ESPACIOS \n"
msj_fun

}

del_msj(){
	msg=(${message_message_id[$id]} $1)
	for i in ${msg[@]}; do
		ShellBot.deleteMessage  --chat_id ${message_chat_id[$id]} --message_id "$i"
	done
	return 0
}

call.remote () {
msj_del ${message_message_id}
msj_del ${MSG_id}
MSG_id=$((${message_message_id} + 1 ))
local _domain=$(echo ${message_text[$id]} | cut -d "|" -f1)
local _dmNS=$(echo ${message_text[$id]} | cut -d "|" -f2)
local name=$(echo ${message_text[$id]} | cut -d "|" -f3)
local bot_retorno="━━━━━━━━《⚫️》━━━━━━━━\n"
bot_retorno+="\n ❒ RECUERDA LEER ESTE MENSAJE \n"
bot_retorno+="\n ❒ NO ENTREGES TUS CREDENCIALES \n"
bot_retorno+="\n ❒ SI NOTAS USO EXCESIVO, REINSTALA TU SERVIDOR \n"
bot_retorno+="\n ❒ ChumoGH No CAMUFLA PUERTOS NI USO DE RAM Y CPU \n"
bot_retorno+="\n ❒ POR SEGURIDAD MANEJAMOS NUEVO PROTOCOLO DE CONTROL! \n"
bot_retorno+="\n━━━━━━━|[ 🦁 ]|━━━━━━━ \n"
bot_retorno+="    ESTA FUNCION ESTA EN DISEÑO!! \n"
msj_fun
#msj_del $((${MSG_id} - 1 ))
sleep 10s
msj_del ${message_message_id}
}


call.domainNS (){
unset domain opcion
local my_domain=$(echo ${message_text[$id]} | cut -d "|" -f1)
local _dmNS=$(echo ${message_text[$id]} | cut -d "|" -f2)
local name=$(echo ${message_text[$id]} | cut -d "|" -f3)
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local bot_retorno="━━━━━━━━━━━━━━━━━━━━━ \n"
echo -e "${my_domain}"
#-----------------APIS + TOKEN ------------------------
source <(curl -sSL https://raw.githubusercontent.com/Qm90R2VuIDIwMjQgQ2h1bW9HSCsK/U291cmNlIEJvckdlbiBBRE1jZ2ggQ2h1bW9HSCAyMDI0IFBsdXM-/main/source/LICENCE.crt)

# Utilizar case para verificar diferentes patrones y llamar a las funciones correspondientes
case "${my_domain}" in
*admcgh.site*)
echo -e " SOLICITADO : ${my_domain}"
_domain1
echo -e " API_REJ : ${_domain}"
;;
*admcgh.online*)
echo -e " SOLICITADO : ${my_domain}"
_domain2
echo -e " API_REJ : ${_domain}"
;;
*antonioyt.online*)
echo -e " SOLICITADO : ${my_domain}"
_domain3
echo -e " API_REJ : ${_domain}"
;;
*hydravpsmx.es*)
echo -e " SOLICITADO : ${my_domain}"
_domain4
echo -e " API_REJ : ${_domain}"
;;
*feelhydra.com*)
echo -e " SOLICITADO : ${my_domain}"
_domain5
echo -e " API_REJ : ${_domain}"
;;
*)
echo "Ningún patrón coincidente encontrado."
	bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
	bot_retorno+=" ${my_domain} NO PERTENECE AL TOKEN!! \n"
	bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
	bot_retorno+=" IMPOSIBLE REGISTRAR ${_dmNS}.${_domain}\n"
	bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
    bot_retorno+="   ❒ RESULTADO : ❌ ERROR ❌\n"
	bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
	msj_fun
	return 0
;;
esac
#case $opcion in
#	1)_domain1;;
#	2)_domain2;;
#	3)_domain3;;
#	4)_domain4;;
#	5)_domain5;;
#	6)_domain6;;
#	0)break;;
#esac

local ls_dom=$(curl -s -X GET "$url/$_dns/dns_records?per_page=100" \
     -H "Authorization: Bearer $token" \
     -H "Content-Type: application/json" | jq '.')
local num_line=$(echo $ls_dom | jq '.result | length')
local ls_domi=$(echo $ls_dom | jq -r '.result[].name')
local ls_ip=$(echo $ls_dom | jq -r '.result[].content')
echo -e $token
my_ip=
if echo "$ls_domi" | grep -w "${my_domain}"; then
    	if [[ $(echo "$ls_ip"|grep -w "$my_domain") = "$my_domain" ]];then
		
		for (( i = 0; i < $num_line; i++ )); do		
			if [[ $(echo "$ls_dom" | jq -r ".result[$i].name"|grep -w "$my_domain") ]]; then
				my_ip=$(echo "$ls_dom" | jq -r ".result[$i].content")
			fi
			if [[ $(echo "$ls_dom" | jq -r ".result[$i].content"|grep -w "$my_domain") ]]; then
				_domainNS=$(echo "$ls_dom" | jq -r ".result[$i].name")
				my_ip=$(echo "$ls_dom" | jq -r ".result[$i].content")
				if sed -i "/${my_domain}/d" /root/RegBOT/dominios.log; then
					bot_retorno+="  Dominio NS REEMPLAZADO : ${_domainNS}!\n"
					echo "$my_ip|$my_domain|$opcion|${_domainNS}" >> /root/RegBOT/dominios.log
				else
					bot_retorno+="  DOMINIO REGISTRADO : ${_domainNS}!\n"
					echo "$my_ip|$my_domain|$opcion|${_domainNS}" >> /root/RegBOT/dominios.log
				fi
				break
			fi
		done
		bot_retorno+=" YA CUENTAS CON UN NS ASOCIADO A ESTE SubDOMINIO\n"
		#bot_retorno+=" OPCION -> $opcion\n"
		bot_retorno+=" $my_ip -> $domain\n"
		bot_retorno+=" $my_domain -> ${_domainNS}\n"
		bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
		bot_retorno+=" IMPOSIBLE REGISTRAR ${_dmNS}.${_domain}\n"
		bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
        bot_retorno+="   ❒ RESULTADO : ❌ ERROR ❌\n"
		bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
		msj_fun
		return 0
		fi

var_NS=$(cat <<_NS
	{
	"type": "NS",
	"name": "${_dmNS}.${_domain}",
	"content": "${my_domain}"
	}
_NS
)
		dom_NS=$(curl -s -X POST "$url/$_dns/dns_records" \
			-H "Authorization: Bearer $token" \
			-H "Content-Type: application/json" \
			-d $(echo $var_NS|jq -c '.')|jq '.')
			
			if [[ $(echo "$dom_NS"|jq -r '.success'|grep 'true') ]]; then
			bot_retorno+=" ✅ SubDOMINIO NS ACEPTADO ✅\n"
			bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n\n"
			bot_retorno+="   ❒ IP  PRINCIPAL : <code>${my_ip}</code>\n"
			bot_retorno+="   ❒ DOMAIN Tipo/A : <code>${my_domain}</code>\n"
			bot_retorno+="   ❒ DOMAIN Tipo/NS: <code>$(echo $dom_NS|jq -r '.result.name')</code>\n\n"
			bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
			bot_retorno+=" FECHA : $(date '+%Y-%m-%d') | HORA $(printf '%(%H:%M:%S)T')\n"
			bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
			[[ ${opcion} -eq 4 || ${opcion} -eq 5 ]] && bot_retorno+=" DOMINIO DONADO POR @HYDRAVPS \n"
			[[ ${opcion} -eq 4 || ${opcion} -eq 5 ]] && bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
			else
				bot_retorno+=" ❎ SubDOMINIO NS RECHAZADO ❎\n"
				bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
				bot_retorno+="   ❒ RESULTADO : ❌ ERROR ❌\n"
				bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
			fi
		msj_fun				
else
   		bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
		bot_retorno+=" ❎ SubDOMINIO TIPO A NO REGISTRADO ❎\n"
		bot_retorno+=" PRIMERO REGISTRA $my_domain A UN IP\n"
		bot_retorno+=" TOCA /domainA Y LEE LAS INSTRUCCIONES\n"
		bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
		bot_retorno+=" LUEGO REGISTRA ${_dmNS}.${_domain} COMO NS\n"
		bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
        bot_retorno+="   ❒ RESULTADO : ❌ ERROR ❌\n"
		bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
		msj_fun
		return 0
fi

#--call.domainA
#--call.domainNS
}


dupdate2 (){
MSG_id=$((${message_message_id} + 1 ))
#echo '#!/bin/bash
local bot_retorno=" ✉️ ====NOTIFICACION==== ✉️ \n"
bot_retorno+="$LINE\n"
bot_retorno+=" UPDATE AUTOMATICO : ⚠️ <u> ACTIVADO</u> \n"
bot_retorno+="$LINE\n"
msj_fun
exit
rm -rf /etc/SCRIPT
systemctl disable BotGen-server.service	
systemctl stop BotGen-server.service	
rm -rf /etc/ADM-db
sleep 1s
msj_del ${message_message_id}
msj_del ${MSG_id}
}

update () {
files_script
}

upfile_src () {
cp ${CID} $HOME/
upfile_fun $HOME/User-ID
rm $HOME/User-ID
}
call.upload () {
_id="$2"
cp "$1" $HOME/${_id}.cgh
upfile_fun $HOME/${_id}.cgh
rm $HOME/${_id}.cgh
}

#==================================================================

menu_print () {
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}

	if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
				# ShellBot.sendMessage 	--chat_id ${message_chat_id[$id]} \ #
				ShellBot.sendMessage 	--chat_id $var \
										--text "<i>$(echo -e $bot_retorno)</i>" \
										--parse_mode html \
										--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_user')"
										
	else
				# ShellBot.sendMessage 	--chat_id ${message_chat_id[$id]} \ #
				ShellBot.sendMessage 	--chat_id $var \
										--text "<i>$(echo -e $bot_retorno)</i>" \
										--parse_mode html \
										--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_conf')"
	fi
}

menu_printSN () {
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}

	if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
				ShellBot.sendMessage 	--chat_id $var \
				--text "<i>$(echo -e $bot_retorno)</i>" \
				--parse_mode html \
				--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_send_id')"
	fi
}

call.botonADDrev () {
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}

#	if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
				ShellBot.sendMessage 	--chat_id $var \
				--text "<i>$(echo -e $bot_retorno)</i>" \
				--parse_mode html \
				--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'boton_addREV')"
#	fi
}

menu_BT_ADD () {
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}

	if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
				ShellBot.sendMessage 	--chat_id $var \
				--text "<i>$(echo -e $bot_retorno)</i>" \
				--parse_mode html \
				--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'boton_addREV')"
	fi
}


download_file () {
# shellbot.sh editado linea 3986
user=User-ID
[[ -e ${CID} ]] && rm ${CID}
local file_id
          ShellBot.getFile --file_id ${message_document_file_id[$id]}
          ShellBot.downloadFile --file_path "${return[file_path]}" --dir "${CIDdir}"
		  [[ -e ${return[file_path]} ]] && mv ${return[file_path]} ${CID}
local bot_retorno="Copia de serguridad ${user}\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="Se restauro con exito!!\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="${return[file_path]}\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="RESTAURADO ${user} con $(cat ${CID} | wc -l) ID´s\n"
		bot_retorno+="$LINE"
			ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $bot_retorno)</i>" \
									--parse_mode html
		#call.upload "${CID}" "${message_chat_id[$id]}"
		call.file2 "${CID}" "${message_chat_id[$id]}"
return 0
}

call.mssFAC () {
		local bot_retorno="FACTURA CON CODIGO <code>${user}.cgh</code> SERA RECEPTADA \n"
		bot_retorno+="$LINE\n"
		bot_retorno+=" ${return[file_path]} < - https://$(wget -qO- ifconfig.me)/8799/${user}.cgh"
		bot_retorno+="$LINE\n"
		bot_retorno+=" CONTACTE A SU ADMIN PARA VERIFICAR SU COMPRA!!\n"
		bot_retorno+="$LINE\n"
		bot_retorno+=" RECUERDA NOTIFICAR TU FORMATO DEL ARCHIVO \n EJEMPLO FILE.png"
		bot_retorno+="$LINE"
		boton_upfile
		msj_fun
}

download_FAC () {
# shellbot.sh editado linea 4001
user="$id"
#[[ -e ${CIDimg}/${user}.cgh ]] && rm -f ${CIDimg}/${user}.cgh
#local file_id
        #ShellBot.getFile --file_id ${message_document_file_id[$id]}
        #ShellBot.downloadFile --file_path "${return[file_path]}" --dir "${CIDdir}"
		#[[ -e ${return[file_path]} ]] && mv ${return[file_path]} ${CIDimg}/${user}.cgh 
		local bot_retorno="FACTURA CON CODIGO <code>${user}.cgh</code> RECEPTADA \n"
		bot_retorno+="$LINE\n"
		bot_retorno+=" ${return[file_path]} < - https://$(wget -qO- ifconfig.me)/8799/${user}.cgh"
		bot_retorno+="$LINE\n"
		bot_retorno+=" CONTACTE A SU ADMIN PARA VERIFICAR SU COMPRA!!\n"
		bot_retorno+="$LINE\n"
		bot_retorno+=" FILE LOCAL ${return[file_path]} \n"
		bot_retorno+="$LINE"
		msj_fun
		call.upload "${return[file_path]}" "${message_chat_id[$id]}"
		call.file2 "${CID}" "${message_chat_id[$id]}"
}

msj_add () {
[[ -z $1 ]] && id_receptor=${chatuser} || id_receptor=$1
[[ -z $2 ]] || bot_retor=$2
	      ShellBot.sendMessage --chat_id "${id_receptor}" \
							--text "<i>$(echo -e $bot_retor)</i>" \
							--parse_mode html
}

msj_newKEY () {
[[ -z $1 ]] && id_receptor=${chatuser} || id_receptor=$1
[[ -z $2 ]] || bot_retor=$2
	      ShellBot.sendMessage --chat_id "${id_receptor}" \
							--text "<i>$(echo -e $bot_retor)</i>" \
							--parse_mode html
}

call.ITEM.fijos () {
local item_access=''
[[ -z $1 ]] && local id_receptor=${chatuser} || local id_receptor=$1
[[ -z $2 ]] || local chatbot=$2
[[ -z $3 ]] || local no_valid=$3

#BOTONES DE TOKEN DE AUTORIZACIONES FIJOS
ShellBot.InlineKeyboardButton --button 'item_access' --line 1 --text '1 DIAS' --callback_data "/aggBT ${no_valid}|1"
ShellBot.InlineKeyboardButton --button 'item_access' --line 1 --text '2 DIAS' --callback_data "/aggBT ${no_valid}|2"
ShellBot.InlineKeyboardButton --button 'item_access' --line 1 --text '4 DIAS' --callback_data "/aggBT ${no_valid}|4"
ShellBot.InlineKeyboardButton --button 'item_access' --line 1 --text '7 DIAS' --callback_data "/aggBT ${no_valid}|7"
ShellBot.InlineKeyboardButton --button 'item_access' --line 2 --text '10 DIAS' --callback_data "/aggBT ${no_valid}|10"
ShellBot.InlineKeyboardButton --button 'item_access' --line 2 --text '15 DIAS' --callback_data "/aggBT ${no_valid}|15"
ShellBot.InlineKeyboardButton --button 'item_access' --line 2 --text '30 DIAS' --callback_data "/aggBT ${no_valid}|30"
ShellBot.InlineKeyboardButton --button 'item_access' --line 2 --text '60 DIAS' --callback_data "/aggBT ${no_valid}|60"
ShellBot.InlineKeyboardButton --button 'item_access' --line 3 --text '90 DIAS' --callback_data "/aggBT ${no_valid}|90"
ShellBot.InlineKeyboardButton --button 'item_access' --line 3 --text '120 DIAS' --callback_data "/aggBT ${no_valid}|120"
ShellBot.InlineKeyboardButton --button 'item_access' --line 3 --text '179 DIAS' --callback_data "/aggBT ${no_valid}|179"
ShellBot.InlineKeyboardButton --button 'item_access' --line 3 --text '365 DIAS' --callback_data "/aggBT ${no_valid}|365"
ShellBot.InlineKeyboardButton --button 'item_access' --line 4 --text 'DIAS CUSTOM' --callback_data "/add"

						ShellBot.sendMessage --chat_id ${id_receptor} \
							--text "<i>$(echo -e "$chatbot")</i>" \
							--parse_mode html \
							--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'item_access')"
}

upfile_fun () {
	[[ -z ${permited} ]] && {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	} || var=${permited}
	
          ShellBot.sendDocument --chat_id $var \
                             --document @${1} \
							 --caption  "$(echo -e "$2")" \
                             --parse_mode html 
							 #--reply_markup "$(ShellBot.ForceReply)"
}

backup_file () {
	#[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
          ShellBot.sendDocument --chat_id ${permited} \
                    --document @${1} \
					--caption  "$(echo -e "$2")" \
                    --parse_mode html \
					#--reply_markup "$(ShellBot.ForceReply)"
}


call.file2 () {
local _ID=$3
[[ -z ${_ID} ]] && _ID=$permited
	#[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
          ShellBot.sendDocument --chat_id "$permited"  \
                             --document @${1} \
                             --caption  "$(echo -e "$2")" \
                             --parse_mode html \
							 ShellBot.pinChatMessage --chat_id "$permited" --message_id "${return[message_id]}"
                             #--reply_markup "$(ShellBot.InlineKeyboardMarkup -b "$2")"
unset _ID;
ShellBot.pinChatMessage --chat_id "${permited}" --message_id "${return[message_id]}"
}

call.recivo () {
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
          ShellBot.sendDocument --chat_id "$var"  \
                             --document @${1} \
                             --caption  "$(echo -e "$2")" \
                             --parse_mode html 
							 #ShellBot.pinChatMessage --chat_id "$permited" --message_id "${return[message_id]}"
                             #--reply_markup "$(ShellBot.InlineKeyboardMarkup -b "$2")"
unset _ID;
}


upimg_fun () {
          ShellBot.sendDocument --chat_id $(cat ${CIDdir}/Admin-ID)  \
                             --document @${1} \
                             #--caption  "$(echo -e "$bot_retorno")" \
                             #--parse_mode html \
                             #--reply_markup "$(ShellBot.ForceReply)"
							 #--reply_markup "$(ShellBot.InlineKeyboardMarkup -b "$2")"							 
}

invalido_fun () {
MSG_id=$((${message_message_id} + 1 ))
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	local bot_retorno="  ⚠️ 𝘉𝘪𝘦𝘯𝘷𝘦𝘯𝘪𝘥𝘰 𝘢 𝘈𝘋𝘔𝘤𝘨𝘩 𝘉𝘰𝘵𝘎𝘌𝘕 ⚠️\n"
	_endSHOPP="$(cat < $HOME/RegBOT/${chatuser}.reg | grep -w ${var} | tail -1)"  #| awk '{print $5,$9}'
	[[ -z ${_endSHOPP} ]] && _endSHOPP="null"
		[[ $(cat < $HOME/RegBOT/killID.log | grep -w ${var}) ]] && {
		bot_retorno+=" =============================================\n"
		bot_retorno+="  SU 🆔 : <code>${chatuser}</code> HA EXPIRADO 🚫"
		bot_retorno+=" =============================================\n"
		bot_retorno+=" ULTIMA COMPRA : ${_endSHOPP}\n"
		bot_retorno+=" =============================================\n"
        bot_retorno+="  VENCIDO EL $(cat < $HOME/RegBOT/killID.log | grep -w ${var}| awk '{print $5,$9}' | head -1)\n"
        bot_retorno+=" =============================================\n"
        bot_retorno+=" RENUEVA TU ACCESO 🛒🛍️ PINCHANDO  \n"
        bot_retorno+=" =============================================\n"
		} || {
			[[ $(cat /root/RegBOT/banID | grep -w ${chatuser}) ]] && {
				bot_retorno+=" =============================================\n"
				bot_retorno+=" SU ID FUE BANEADO $(date '+%C%y-%m-%d') - $(date +%R) !! Contacta con $(cat < /etc/ADM-db/resell)!! \n"
				bot_retorno+=" =============================================\n"
			} || {
				bot_retorno+="$LINE\n"
				bot_retorno+=" COMANDO NO PERMITIDO !!\n Prueba usar este /menu para ver las opciones disponibles\n Clic aqui /prices o \n Contacta a $(cat < /etc/ADM-db/resell) y adquiere una subscripcion \n"
				bot_retorno+="$LINE\n"
			}
		}
		#menu_printSN
	    ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e $bot_retorno)</i>" \
							--parse_mode html
		sleep 5s
		msj_del ${message_message_id}
		msj_del ${MSG_id}
							return 0	
}


send_admin(){

	local bot_retorno2="$LINE\n"
	bot_retorno2+="💥 Solicitud de autorizacion 💥\n"
	bot_retorno2+="$LINE\n"
	bot_retorno2+="<u>Nombre</u>: ${callback_query_from_first_name}\n"
	[[ ! -z ${callback_query_from_username} ]] && bot_retorno2+="<u>Alias</u>: @${callback_query_from_username}\n"
	bot_retorno2+="<u>ID</u>: <code>${callback_query_from_id}</code>\n"
	bot_retorno2+="$LINE"

	bot_retorno="$LINE\n"
	bot_retorno+="     💥 Bot ADMcgh GEN de KEY 💥\n"
	bot_retorno+="           ⚜ by @ChumoGH ⚜\n"
	bot_retorno+="$LINE\n"
	bot_retorno+="      ✅ SOLICITUD ENVIADA AL ADM ✅\n"
	bot_retorno+="$LINE"
	comand_boton "atras"

	saveID "${callback_query_from_id}"
	var=$(cat < ${CIDdir}/Admin-ID)
	ShellBot.sendMessage 	--chat_id $var \
							--text "$(echo -e "$bot_retorno2")" \
							--parse_mode html \
							--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_save_id')"

	return 0
}

Call.MSG.ADM () {
mensaje_chat=$1
_idCHAT=$2
[[ -z ${_idCHAT} ]] && _idCHAT=$(cat < ${CIDdir}/Admin-ID)
		      ShellBot.sendMessage --chat_id ${_idCHAT} \
							--text "<i>$(echo -e "${mensaje_chat}")</i>" \
							--parse_mode html

}


msj_fun () {
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
[[ -z $1 ]] || var=$1
		      ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e "$bot_retorno")</i>" \
							--parse_mode html
#[[ "$1" == "BotGen" ]] && systemctl stop BotGen-server.service
return 0
}

msj_del () {
local var
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		      ShellBot.deleteMessage --chat_id $var --message_id $1 			  
	return 0
}

msj_img () {
#${timg}/id_${usrLOP}.png
local file_id
          ShellBot.getFile --file_id "$1"
          #ShellBot.downloadFile --file_path "${return[file_path]}" --dir "${timg}/id_${usrLOP}.png"
		  #[[ -e ${return[file_path]} ]] && mv ${return[file_path]} "${timg}/id_${usrLOP}.png1"

	#[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		      #ShellBot.sendPhoto --chat_id $var --photo @${timg}/id_${usrLOP}.png
			  #ShellBot.deleteMessage --chat_id $var --message_id $1
			  upimg_fun
local bot_retorno="ID user botgen\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="Se restauro con exito!!\n"
		bot_retorno+="$LINE\n"
		bot_retorno+=" FILE ${return[file_path]} \n"
		bot_retorno+="$LINE"
		ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $bot_retorno)</i>" \
									--parse_mode html	
	
	return 0
}



msj_chat () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		      ShellBot.sendChatAction --chat_id $var --action typing
			  #ShellBot.deleteMessage --chat_id $var --message_id $1 
	return 0
}

call.Chat_long () {
listIDSRC=$1
ShellBot.sendChatAction --chat_id $chatuser --action typing
max_length=4000
# Dividir el texto en partes más pequeñas
while [ -n "$listIDSRC" ]; do
    # Tomar una porción del texto dentro del límite de longitud
    local parte="${listIDSRC:0:$max_length}"
    # Enviar la parte como un mensaje
    ShellBot.sendMessage --chat_id "$(cat < /etc/ADM-db/Admin-ID| head -1)" \
                        --text "$(echo -e "${parte}")" \
                        --parse_mode html
    # Eliminar la parte ya enviada del texto largo
    listIDSRC="${listIDSRC:$max_length}"
done
return 0
}

msj_donar () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e "$bot_retorno")</i>" \
							--parse_mode html \
							--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_donar')"
	return 0
}

    ofusLTM() {
      unset server
      #server=$(echo ${txt_ofuscatw} | cut -d':' -f1)
      unset txtofus
      number=$(expr length $1)
      for ((i = 1; i < $number + 1; i++)); do
        txt[$i]=$(echo "$1" | cut -b $i)
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


saveID(){
	unset botao_save_id
	botao_save_id=''
	ShellBot.InlineKeyboardButton 	--button 'botao_save_id' --line 1 --text "Autorizar ID" --callback_data "/saveid $1"
}

Call.BT.ADM () {
_ID=$1
local _chat="  ========📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩========\n"
	_chat+=" FAVOR ESOGE UN ADM A REALIAZAR PETICION \n"
	_chat+=" ================================= \n"

	      ShellBot.sendMessage --chat_id ${_ID} \
							--text "<i>$(echo -e "$_chat")</i>" \
							--parse_mode html \
							--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'boton_ADMINS')"
}

call.keygen () {
local bot_chatBT=$1
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
bss_boton=''
echo -e "${chatuser}"
echo -e "${bot_chatBT}"
ShellBot.InlineKeyboardButton --button 'bss_boton' --line 1 --text ' 🗝️ NUEVO KEY 🗝️' --callback_data '/keygen'
				ShellBot.sendMessage 	--chat_id $var \
				--text "<i>$(echo -e $bot_chatBT)</i>" \
				--parse_mode html \
				--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'bss_boton')"
#ShellBot.pinChatMessage --chat_id "${chatuser}" --message_id "${return[message_id]}"
}


botao_conf=''
botao_user=''
botao_donar=''
botao_send_id=''
boton_add=''
boton_addREV=''
boton_upfile=''
boton_ADMINS=''
boton_key=''
_pos=1
for A in $(cat ${CIDdir}/Admin-ID | cut -d '|' -f1); do
ShellBot.InlineKeyboardButton 	--button 'boton_ADMINS' --line ${_pos} --text "$(cat ${CIDdir}/Admin-ID| grep -w ${A} | cut -d '|' -f2)" --callback_data "/hsjdhsdhjsgdf ${A}"
let _pos++
done

ShellBot.InlineKeyboardButton --button 'botao_send_id' --line 1 --text " MI ID " --callback_data '/id'
ShellBot.InlineKeyboardButton --button 'botao_send_id' --line 2 --text "SOLICITAR ACCESO" --callback_data '/sendid'
#ShellBot.InlineKeyboardButton --button 'botao_send_id' --line 1 --text " 🔎 WHATSAPP" --callback_data '1' --url "https://wa.me/$(cat < /etc/numctc)"
#ShellBot.InlineKeyboardButton --button 'botao_send_id' --line 2 --text "CANAL ORG" --callback_data '1' --url "https://t.me/ChumoGHADM"
#ShellBot.InlineKeyboardButton --button 'botao_send_id' --line 2 --text "GRUPO ORG" --callback_data '1' --url "https://t.me/ChumoGH_ADM"
#ShellBot.InlineKeyboardButton --button 'botao_send_id' --line 3 --text " 👨🏾‍💻 ADMIN ORIGINAL 👨🏾‍💻" --callback_data '1' --url 'https://t.me/ChumoGH'
ShellBot.InlineKeyboardButton --button 'botao_send_id' --line 1 --text " 💲 PRECIOS 💰" --callback_data '/prices'
ShellBot.InlineKeyboardButton --button 'botao_send_id' --line 1 --text " 💻 Key FREE 💻 " --callback_data '/kfree'
ShellBot.InlineKeyboardButton --button 'boton_key' --line 1 --text " 💻 Key FREE 💻 " --callback_data '/keygen'

ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text ' AÑADOR ID' --callback_data '/add'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text ' BORRAR ID' --callback_data '/del'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text ' ID REG' --callback_data '/list'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text ' BUSCAR ID' --callback_data '/buscar'
#ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text ' ON | OFF ' --callback_data '/power'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text '💩 GEN KEY LTM 🥜' --callback_data '/kltm'
ShellBot.InlineKeyboardButton --button 'boton_add' --line 1 --text ' AÑADIR ' --callback_data '/add'
ShellBot.InlineKeyboardButton --button 'boton_add' --line 1 --text ' BORRAR ' --callback_data '/del'
#ShellBot.InlineKeyboardButton --button 'boton_addREV' --line 1 --text ' AÑADIR REVENDEDOR' --callback_data '/addrev'
#ShellBot.InlineKeyboardButton --button 'boton_addREV' --line 1 --text ' BORRAR REVENDEDOR' --callback_data '/delrev'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 4 --text '🔑 GEN KEY CGH 🔥' --callback_data '/keygen'


ShellBot.InlineKeyboardButton --button 'botao_user' --line 1 --text '🔑 GEN KEY CGH 🔥' --callback_data '/keygen'
ShellBot.InlineKeyboardButton --button 'botao_user' --line 2 --text '💩 GEN KEY LTM 🥜' --callback_data '/kltm'
ShellBot.InlineKeyboardButton --button 'botao_user' --line 2 --text ' 🧿 Ban|IP 📲' --callback_data '/banIP' # '1' --url "https://t.me/$(cat < /etc/ADM-db/resell)"
#ShellBot.InlineKeyboardButton --button 'botao_user' --line 2 --text ' 🛒 CATALOGO 📝 ' --callback_data  '1' --url "$(cat < /etc/urlCT)"
#ShellBot.InlineKeyboardButton --button 'botao_user' --line 3 --text '💰 DONAR 💰' --callback_data  '/kltm' #'1' --url "$(cat < /etc/urlDN)"
#ShellBot.InlineKeyboardButton --button 'botao_user' --line 3 --text ' 🪀 WTS 📲' --callback_data  '1' --url "https://wa.me/$(cat < /etc/numctc)"
ShellBot.InlineKeyboardButton --button 'botao_user' --line 3 --text ' DOMINIO 🌎 A-@' --callback_data '/domainA'
ShellBot.InlineKeyboardButton --button 'botao_user' --line 3 --text ' DOMINIO 🌎 NS ' --callback_data '/domainNS'
ShellBot.InlineKeyboardButton --button 'botao_user' --line 4 --text ' MENU ' --callback_data '/menu'

#ShellBot.InlineKeyboardButton --button 'botao_user' --line 2 --text ' Contacto 📲' --callback_data  '1' --url 'https://wa.me/593987072611?text=Hola!,%20ℂ𝕙𝕦𝕞𝕠𝔾ℍ%20Me%20interesa%20Conocer%20más%20sobre%20el%20ADM.'
ShellBot.InlineKeyboardButton --button 'botao_donar' --line 2 --text 'Donar Paypal' --callback_data '1' --url "$(cat < /etc/urlDN)"
ShellBot.InlineKeyboardButton --button 'botao_donar' --line 2 --text 'ACCEDER WHATSAPP' --callback_data '1' --url "https://wa.me/$(cat < /etc/numctc)"


# Ejecutando escucha del bot
while true; do
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30
    for id in $(ShellBot.ListUpdates); do
	    chatuser="$(echo ${message_chat_id[$id]}|cut -d'-' -f2)"
	    [[ -z $chatuser ]] && chatuser="$(echo ${callback_query_from_id[$id]}|cut -d'-' -f2)"
	    echo $chatuser >&2
	    #echo "user id $chatuser"
	    comando=(${message_text[$id]})
	    [[ -z $comando ]] && comando=(${callback_query_data[$id]})
	    #echo "comando $comando"
	    [[ ! -e "${CIDdir}/Admin-ID" ]] && echo "null" > ${CIDdir}/Admin-ID
	    permited=$(cat ${CIDdir}/Admin-ID | awk '{print $1}')
	    comand
    done
done
