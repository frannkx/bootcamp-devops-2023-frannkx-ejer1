#### Declaracion de variables requeridas

R='\033[0;31m'   #'0;31' is Red's ANSI color code
G='\033[0;32m'   #'0;32' is Green's ANSI color code
Y='\033[1;33m'   #'1;32' is Yellow's ANSI color code
B='\033[0;34m'   #'0;34' is Blue's ANSI color code
NOCOLOR='\033[0m'
DEBIAN_FRONTEND=noninteractive
DEPLOY_LOG=Deploy-`date +%e-%m-%Y-%T`.log

#### Definicion de variables personalizadas
URL_REPO=https://github.com/frannkx/bootcamp-devops-2023-frannkx-ejer1
REPO=bootcamp-devops-2023-frannkx-ejer1
BRANCH=main
#URL_REPO=https://github.com/roxsross/bootcamp-devops-2023.git
#REPO=bootcamp-devops-2023
#BRANCH=clase2-linux-bash
PROYECTO=app-295devops-travel
DB_USER="mariauser"
DB_PASS="DbR00t"
DB_HOST="localhost" #Modificar solo si la BD esta en un nodo externo
DISCORD="https://discord.com/api/webhooks/1154865920741752872/au1jkQ7v9LgQJ131qFnFqP-WWehD40poZJXRGEYUDErXHLQJ_BBszUFtVj8g3pu9bm7h"

########################## Banner #############################################
echo -e $G '
############# Bienvenido al deploy de Francisco Paredes #################
#	   ______                                  _               			#
#	  |  ____|                                | |              			#
#	  | |__     _ __    __ _   _ __    _ __   | | __ __  __    			#
#	  |  __|   | !__|  / _` | | !_ \  | !_ \  | |/ / \ \/ /    			#
#	  | |      | |    | (_| | | | | | | | | | |   <   >  <     			#
#	  |_|      |_|     \__,_| |_| |_| |_| |_| |_|\_\ /_/\_\    			#
#                                                           			#
# Email: frannkx@gmail.com												#
# Discord: frannkx_88198                                    			#
# Github: https://github.com/frannkx/bootcamp-devops-2023-frannkx-ejer1	#
# Linkedin: https://www.linkedin.com/in/frannkx/            			#
#########################################################################        
' $NOCOLOR                                                                                                             
###############################################################################

# Verificacion de usuario root
if [ $UID -eq 0 ] ; then
	echo -e $G "\n Verificacion de usuario root \n Se confirma que el usuario `whoami` con user id $UID tiene privilegios necesarios para la instalación de paquetes" $NOCOLOR
	echo -e $G "\n Verificacion de usuario root \n Se confirma que el usuario `whoami` con user id $UID tiene privilegios necesarios para la instalación de paquetes" $NOCOLOR >> $DEPLOY_LOG
else
	echo -e $R "\n Verificacion de usuario root \n El usuario `whoami` con user id $UID no tiene privilegios suficientes para realizar la instalación de paquetes" $NOCOLOR
	echo -e $R "\n Verificacion de usuario root - El usuario `whoami` con user id $UID no tiene privilegios suficientes para realizar la instalación de paquetes" $NOCOLOR >> $DEPLOY_LOG
	exit
fi

############################# STAGE 1: Init ########################################
echo -e "\n`date` $B Ejecutando STAGE 1: Init - Instalando paquetes necesarios $NOCOLOR" 
echo -e "\n `date` $B Ejecutando STAGE 1: Init - Instalando paquetes necesarios $NOCOLOR" >> $DEPLOY_LOG

# Actualizando versiones de paquetes 

echo -e "\n `date` $G Actualizando sistema operativo $NOCOLOR"
sudo apt-get update -y >> $DEPLOY_LOG

# Instalando Git
if dpkg -s git >/dev/null 2>&1; then
	echo -e "\n `date` $G Instalacion de Git \n Git se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Instalacion de Git \n Git se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG
else
    echo -e "\n `date` $G Instalacion de Git \n $Y no se encuentra instalado, instalando git $NOCOLOR"
	echo -e "\n `date` $G Instalacion de Git - $Y no se encuentra instalado, instalando git $NOCOLOR" >> $DEPLOY_LOG
	sudo apt install git -y >> $DEPLOY_LOG
fi

# Instalando curl
if dpkg -s curl >/dev/null 2>&1; then
	echo -e "\n `date` $G Instalacion de Curl \n curl se encuentra instalado $NOCOLOR" 
	echo -e "\n `date` $G Instalacion de Curl \n curl se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG
else
    echo -e "\n `date` $G Instalacion de Curl \n $Y no se encuentra instalado, instalando curl $NOCOLOR"
	echo -e "\n `date` $G Instalacion de Curl - $Y no se encuentra instalado, instalando curl $NOCOLOR" >> $DEPLOY_LOG
	sudo apt-get install curl -y >> $DEPLOY_LOG
fi

# Instalando Apache2
if dpkg -s apache2 >/dev/null 2>&1; then
	echo -e "\n `date` $G Instalacion de Apache2 \n Apache2 se encuentra instalado $NOCOLOR" 
	echo -e "\n `date` $G Instalacion de Apache2 \n Apache2 se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG
	sudo systemctl status apache2 >> $DEPLOY_LOG
else
    echo -e "\n `date` $G Instalacion de Apache2 \n $Y no se encuentra instalado, instalando Apache2 $NOCOLOR"
	echo -e "\n `date` $G Instalacion de Apache2 - $Y no se encuentra instalado, instalando Apache2 $NOCOLOR" >> $DEPLOY_LOG
	sudo apt-get install apache2 -y >> $DEPLOY_LOG
	sudo systemctl enable apache2 >> $DEPLOY_LOG
	sudo systemctl status apache2 >> $DEPLOY_LOG
fi

# Instalando PHP
if dpkg -s php >/dev/null 2>&1; then
	echo -e "\n `date` $G Instalacion de PHP \n PHP se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Instalacion de PHP \n PHP se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG             
else
    echo -e "\n `date`  $G Instalacion de PHP \n $Y no se encuentra instalado, instalando PHP $NOCOLOR"
	echo -e "\n `date`  $G Instalacion de PHP - $Y no se encuentra instalado, instalando PHP $NOCOLOR" >> $DEPLOY_LOG    
	sudo apt-get install php -y >> $DEPLOY_LOG 
fi

if dpkg -s libapache2-mod-php >/dev/null 2>&1; then
	echo -e "\n `date` $G Instalacion de libapache2-mod-php \n libapache2-mod-php se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Instalacion de libapache2-mod-php \n libapache2-mod-php se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG             
else
    echo -e "\n `date`  $G Instalacion de libapache2-mod-php \n $Y no se encuentra instalado, instalando libapache2-mod-php $NOCOLOR"
	echo -e "\n `date`  $G Instalacion de libapache2-mod-php - $Y no se encuentra instalado, instalando libapache2-mod-php $NOCOLOR" >> $DEPLOY_LOG    
	sudo apt-get install libapache2-mod-php -y >> $DEPLOY_LOG
fi

if dpkg -s php-mysql >/dev/null 2>&1; then
	echo -e "\n `date` $G Instalacion de PHP-Mysql \n PHP-Mysql se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Instalacion de PHP-Mysql \n PHP-Mysql se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG             
else
    echo -e "\n `date`  $G Instalacion de PHP-Mysql \n $Y no se encuentra instalado, instalando PHP-Mysql $NOCOLOR"
	echo -e "\n `date`  $G Instalacion de PHP-Mysql - $Y no se encuentra instalado, instalando PHP-Mysql $NOCOLOR" >> $DEPLOY_LOG    
	sudo apt-get install php-mysql -y >> $DEPLOY_LOG
fi

if dpkg -s php-mbstring >/dev/null 2>&1; then
	echo -e "\n `date` $G Instalacion de php-mbstring \n php-mbstring se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Instalacion de php-mbstring \n php-mbstring se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG             
else
    echo -e "\n `date`  $G Instalacion de php-mbstring \n $Y no se encuentra instalado, instalando php-mbstring $NOCOLOR"
	echo -e "\n `date`  $G Instalacion de php-mbstring - $Y no se encuentra instalado, instalando php-mbstring $NOCOLOR" >> $DEPLOY_LOG    
	sudo apt-get install php-mbstring -y >> $DEPLOY_LOG
fi

if dpkg -s php-zip >/dev/null 2>&1; then
	echo -e "\n `date` $G Instalacion de php-zip \n php-zip se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Instalacion de php-zip \n php-zip se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG             
else
    echo -e "\n `date`  $G Instalacion de php-zip \n $Y no se encuentra instalado, instalando php-zip $NOCOLOR"
	echo -e "\n `date`  $G Instalacion de php-zip - $Y no se encuentra instalado, instalando php-zip $NOCOLOR" >> $DEPLOY_LOG    
	sudo apt-get install php-zip -y >> $DEPLOY_LOG
fi

if dpkg -s php-gd >/dev/null 2>&1; then
	echo -e "\n `date` $G Instalacion de php-gd \n php-gd se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Instalacion de php-gd \n php-gd se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG             
else
    echo -e "\n `date`  $G Instalacion de php-gd \n $Y no se encuentra instalado, instalando php-gd $NOCOLOR"
	echo -e "\n `date`  $G Instalacion de php-gd - $Y no se encuentra instalado, instalando php-gd $NOCOLOR" >> $DEPLOY_LOG    
	sudo apt-get install php-gd -y >> $DEPLOY_LOG 
fi

if dpkg -s php-json >/dev/null 2>&1; then
	echo -e "\n `date` $G Instalacion de php-json \n php-json se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Instalacion de php-json \n php-json se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG             
else
    echo -e "\n `date`  $G Instalacion de php-json \n $Y no se encuentra instalado, instalando php-json $NOCOLOR"
	echo -e "\n `date`  $G Instalacion de php-json - $Y no se encuentra instalado, instalando php-json $NOCOLOR" >> $DEPLOY_LOG    
	sudo apt-get install php-json -y >> $DEPLOY_LOG
fi

if dpkg -s php-curl >/dev/null 2>&1; then
	echo -e "\n `date` $G Instalacion de php-curl \n php-curl se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Instalacion de php-curl \n php-curl se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG             
else
    echo -e "\n `date`  $G Instalacion de php-curl \n $Y no se encuentra instalado, instalando php-curl $NOCOLOR"
	echo -e "\n `date`  $G Instalacion de php-curl - $Y no se encuentra instalado, instalando php-curl $NOCOLOR" >> $DEPLOY_LOG    
	sudo apt-get install php-curl -y >> $DEPLOY_LOG 
fi

# Instalacion de Base de datos maria DB 
if dpkg -s mariadb-server >/dev/null 2>&1; then 
	echo -e "\n `date` $G Instalacion de mariadb-server \n Mariadb se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Instalacion de mariadb-server \n Mariadb se encuentra instalado $NOCOLOR" >> $DEPLOY_LOG
	sudo systemctl status mariadb >> $DEPLOY_LOG
else    
    echo -e "\n `date` $G Instalacion de mariadb-server \n $Y no se encuentra instalado, instalando Mariadb $NOCOLOR"
	echo -e "\n `date` $G Instalacion de mariadb-server - $Y no se encuentra instalado, instalando Mariadb $NOCOLOR" >> $DEPLOY_LOG
	sudo apt install mariadb-server -y >> $DEPLOY_LOG
	sudo systemctl start mariadb >> $DEPLOY_LOG
	sudo systemctl enable mariadb >> $DEPLOY_LOG
	sudo systemctl status mariadb >> $DEPLOY_LOG
fi

#Creacion de usuarios en bd
echo -e $G "\n Configurando base de datos" $NOCOLOR

cat > db-load-script.sql <<-EOF
CREATE DATABASE devopstravel;
CREATE USER `echo ${DB_USER}`@`echo ${DB_HOST}` IDENTIFIED BY '`echo ${DB_PASS}`';
GRANT ALL PRIVILEGES ON *.* TO `echo ${DB_USER}`@`echo ${DB_HOST}`;
FLUSH PRIVILEGES;
EOF

mysql < db-load-script.sql

# Validando versiones instaladas 
echo -e $G "\n Información del Sistema Operativo" $NOCOLOR
hostnamectl
echo -e $G "\n Version de Git" $NOCOLOR
git --version
git --version >> $DEPLOY_LOG
echo -e $G "\n Version de curl" $NOCOLOR
curl --version
curl --version >> $DEPLOY_LOG
echo -e $G " \n Version de apache2" $NOCOLOR
apache2 -v
apache2 -v >> $DEPLOY_LOG
echo -e $G "\n Version de PHP" $NOCOLOR
php --version
php --version >> $DEPLOY_LOG
echo -e $G "\n Version de MariaDB" $NOCOLOR
mariadb --version
mariadb --version >> $DEPLOY_LOG


############################# STAGE 2: Build ########################################

echo -e "\n\n `date` $B Ejecutando STAGE 2: Build - Clonando Repositorio de aplicacion $NOCOLOR"
echo -e "\n\n  `date` $B Ejecutando STAGE 2: Build - Clonando Repositorio de aplicacion $NOCOLOR" >> $DEPLOY_LOG

#Clonar el repositorio de la aplicación
#Validar si el repositorio de la aplicación no existe realizar un git clone. y si existe un git pull

if [ -d $REPO ] ; then
    echo -e " `date` $G Validando existencia del respositorio \n El repositorio existe $NOCOLOR"
	echo -e " `date` $G Validando existencia del respositorio \n El repositorio existe $NOCOLOR" >> $DEPLOY_LOG
    cd $REPO
	git pull >> $DEPLOY_LOG
	  
else
    echo -e " `date` $G Validando existencia del respositorio \n $Y El repositorio no existe, iniciando clone $NOCOLOR"
	echo -e " `date` $G Validando existencia del respositorio \n $Y El repositorio no existe, iniciando clone $NOCOLOR" >> $DEPLOY_LOG
    git clone $URL_REPO >> $DEPLOY_LOG
	cd $REPO
fi

#Mover al directorio donde se guardar los archivos de configuración de apache

if git branch |grep $BRANCH >/dev/null 2>&1; then
    echo -e $G "Validacion de branch \n Repositorio en rama $BRANCH"
	echo -e $G "Validacion de branch \n Repositorio en rama $BRANCH" >> $DEPLOY_LOG
    mv /var/www/html/index.html /var/www/html/index.html.bkp >> $DEPLOY_LOG
	cp -r $PROYECTO/* /var/www/html/ >> $DEPLOY_LOG
else
    echo -e $R "El repo no esta en $BRANCH \n $Y cambiando a la rama" $NOCOLOR
	echo -e $R "El repo no esta en $BRANCH \n $Y cambiando a la rama" $NOCOLOR >> $DEPLOY_LOG
	git checkout $BRANCH >> $DEPLOY_LOG #Ajuste particulpar para acceder al branch en donde esta la carpeta de la web
	mv /var/www/html/index.html /var/www/html/index.html.bck >> $DEPLOY_LOG
	cp -r $PROYECTO/* /var/www/html/ >> $DEPLOY_LOG
fi

############################# STAGE 3: Deploy ########################################
echo -e "\n\n `date` $B Ejecutando STAGE 3: Deploy - Configurando y desplegando aplicacion $NOCOLOR"
echo -e "\n\n `date` $B Ejecutando STAGE 3: Deploy - Configurando y desplegando aplicacion $NOCOLOR" >> $DEPLOY_LOG

echo -e $G "Cargando data y configurando aplicación $BRANCH" $NOCOLOR
echo -e $G "Cargando data y configurando aplicación $BRANCH" $NOCOLOR >> $DEPLOY_LOG

mysql < $PROYECTO/database/devopstravel.sql >> $DEPLOY_LOG
sed -i s/codeuser/$DB_USER/g /var/www/html/config.php >> $DEPLOY_LOG
sed -i s/'""'/$DB_PASS/g /var/www/html/config.php >> $DEPLOY_LOG

#Ajustar el config de php para que soporte los archivos dinamicos de php agreganfo index.php

sed -i s/DirectoryIndex\ index.html\ index.cgi\ index.pl\ index.php\ index.xhtml\ index.htm/DirectoryIndex\ index.php\ index.html\ index.cgi\ index.pl\ index.xhtml\ index.htm/g  /etc/apache2/mods-enabled/dir.conf >> $DEPLOY_LOG
systemctl reload apache2 >> $DEPLOY_LOG

#Testear existencia del codigo de la aplicación
if curl localhost >/dev/null 2>&1; then
	echo -e $G "Validando sition web \n El sitio esta funcional $BRANCH" $NOCOLOR
	echo -e $G "Validando sition web \n El sitio esta funcional $BRANCH" $NOCOLOR >> $DEPLOY_LOG
else
	echo -e $R "Validando sition web \n No esta funcional el codigo $BRANCH" $NOCOLOR
	echo -e $R "Validando sition web - $Y No esta funcional el codigo $BRANCH" $NOCOLOR >> $DEPLOY_LOG
fi

#Testear la compatibilidad -> ejemplo http://localhost/info.php
curl localhost/info.php
curl localhost/info.php >> $DEPLOY_LOG
#Si te muestra resultado de una pantalla informativa php , estariamos funcional para la siguiente etapa.

############################# STAGE 4: Notify ########################################
echo -e "\n\n `date` $B Ejecutando STAGE 4: Notify - Notificando estatus del sitio al Webhook de Discord $NOCOLOR"
echo -e "\n\n `date` $B Ejecutando STAGE 4: Notify - Notificando estatus del sitio al Webhook de Discord $NOCOLOR" >> $DEPLOY_LOG

#El status de la aplicacion si esta respondiendo correctamente o esta fallando debe reportarse via webhook al canal de discord #deploy-bootcamp
#Informacion a mostrar : Author del Commit, Commit, descripcion, grupo y status

REPO_NAME=$(basename $(git rev-parse --show-toplevel))
REPO_URL=$(git remote get-url origin)
WEB_URL="localhost"
# Realiza una solicitud HTTP GET a la URL
HTTP_STATUS=$(curl -Is "$WEB_URL" | head -n 1)

# Verifica si la respuesta es 200 OK (puedes ajustar esto según tus necesidades)
if [[ "$HTTP_STATUS" == *"200 OK"* ]]; then
  # Obtén información del repositorio
    DEPLOYMENT_INFO2="Despliegue del repositorio $REPO_NAME: "
    DEPLOYMENT_INFO="La página web $WEB_URL está en línea."
    COMMIT="Commit: $(git rev-parse --short HEAD)"
    AUTHOR="Autor: $(git log -1 --pretty=format:'%an')"
    DESCRIPTION="Descripción: $(git log -1 --pretty=format:'%s')"
else
  DEPLOYMENT_INFO="La página web $WEB_URL no está en línea."
fi

# Construye el mensaje
MESSAGE="$DEPLOYMENT_INFO2\n$DEPLOYMENT_INFO\n$COMMIT\n$AUTHOR\n$REPO_URL\n$DESCRIPTION\nEstudiante Individual: Francisco Paredes"
echo -e $G "Notificando al webhook de Discord el siguiente mensaje \n $MESSAGE" $NOCOLOR

# Envía el mensaje a Discord utilizando la API de Discord
curl -X POST -H "Content-Type: application/json" \
     -d '{
       "content": "'"${MESSAGE}"'"
     }' "$DISCORD"

#Copiando log en ruta 
mv $DEPLOY_LOG $PROYECTO/$DEPLOY_LOG
echo -e "\n\n `date` $B Logs almacenados en $PROYECTO/$DEPLOY_LOG $NOCOLOR"