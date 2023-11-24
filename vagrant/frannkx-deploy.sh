#### Declaracion de variables requeridas
# Repositorio
URL_REPO=https://github.com/roxsross/bootcamp-devops-2023.git
REPO=bootcamp-devops-2023
BRANCH=clase2-linux-bash
PROYECTO=app-295devops-travel
DISCORD="https://discord.com/api/webhooks/1154865920741752872/au1jkQ7v9LgQJ131qFnFqP-WWehD40poZJXRGEYUDErXHLQJ_BBszUFtVj8g3pu9bm7h"
R='\033[0;31m'   #'0;31' is Red's ANSI color code
G='\033[0;32m'   #'0;32' is Green's ANSI color code
Y='\033[1;32m'   #'1;32' is Yellow's ANSI color code
B='\033[0;34m'   #'0;34' is Blue's ANSI color code
NOCOLOR='\033[0m'
LOG=`date +%e-%m-%Y-%T`.log
DB_USER="mariauser"
DB_PASS="DbR00t"

########################## Banner #############################################
echo -e $Y '
######## Bienvenido al deploy de Francisco Paredes ########## 
#   ______                                  _               #
#  |  ____|                                | |              #
#  | |__     _ __    __ _   _ __    _ __   | | __ __  __    #
#  |  __|   | !__|  / _` | | !_ \  | !_ \  | |/ / \ \/ /    #
#  | |      | |    | (_| | | | | | | | | | |   <   >  <     #
#  |_|      |_|     \__,_| |_| |_| |_| |_| |_|\_\ /_/\_\    #
#                                                           #
# Email: frannkx@gmail.com                                  #
# Discord: frannkx_88198                                    #
# Linkedin: https://www.linkedin.com/in/frannkx/            #
#############################################################        
' $NOCOLOR                                                                                                             
###############################################################################

# Verificacion de usuario root
if [ $UID -eq 0 ] ; then
	echo -e $G "\n Se confirma que el usuario `whoami` con user id $UID tiene privilegios necesarios para la instalación de paquetes" $NOCOLOR
else
	echo -e $R "\n No se tienen privilegios suficientes para realizar la instalación de paquetes, intentando subir privilegios para avanzar con la instalación" $NOCOLOR
	exit
    #sudo su
    #echo -e $G "\n Ejecutando desde el usuario `whoami`" $NOCOLOR
fi

############################# STAGE 1: Init ########################################
echo -e "\n`date` $B Ejecutando STAGE 1: Init - Instalando paquetes necesarios $NOCOLOR" 
echo -e "\n `date` $B Ejecutando STAGE 1: Init - Instalando paquetes necesarios $NOCOLOR" >> $LOG

# Actualizando versiones de paquetes 

echo -e "\n `date` $G Actualizando sistema operativo $NOCOLOR"
sudo apt-get update -y #&& sudo apt-get upgrade -y

# Instalando Git
if dpkg -s git >/dev/null 2>&1; then
	echo -e "\n `date` $G Git se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Git se encuentra instalado $NOCOLOR" >> $LOG
else
    echo -e "\n `date` $G instalando git $NOCOLOR"
	echo -e "\n `date` $G instalando git $NOCOLOR" >> $LOG
	sudo apt install git -y >> $LOG
fi

# Instalando curl
if dpkg -s curl >/dev/null 2>&1; then
	echo -e "\n `date` $G curl se encuentra instalado $NOCOLOR" 
	echo -e "\n `date` $G curl se encuentra instalado $NOCOLOR" >> $LOG
else
    echo -e "\n `date` $G Instalando curl $NOCOLOR"
	echo -e "\n `date` $G Instalando curl $NOCOLOR" >> $LOG
	sudo apt-get install curl -y >> $LOG
fi

# Instalando Apache2
if dpkg -s apache2 >/dev/null 2>&1; then
	echo -e "\n `date` $G Apache2 se encuentra instalado $NOCOLOR" 
	echo -e "\n `date` $G Apache2 se encuentra instalado $NOCOLOR" >> $LOG
	sudo systemctl status apache2
else
    echo -e "\n `date` $G Instalando Apache2 $NOCOLOR"
	echo -e "\n `date` $G Instalando Apache2 $NOCOLOR" >> $LOG
	sudo apt-get install apache2 -y >> $LOG
	sudo systemctl enable apache2
	sudo systemctl status apache2
fi

# Instalando PHP
if dpkg -s php >/dev/null 2>&1; then
	echo -e "\n `date` $G PHP se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G PHP se encuentra instalado $NOCOLOR" >> $LOG             
else
    echo -e "\n `date`  $G Instalando PHP $NOCOLOR"
	echo -e "\n `date`  $G Instalando PHP $NOCOLOR" >> $LOG    
	sudo apt-get install php -y
fi

if dpkg -s libapache2-mod-php >/dev/null 2>&1; then
	echo -e "\n `date` $G libapache2-mod-php se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G libapache2-mod-php se encuentra instalado $NOCOLOR" >> $LOG             
else
    echo -e "\n `date`  $G Instalando libapache2-mod-php $NOCOLOR"
	echo -e "\n `date`  $G Instalando libapache2-mod-php $NOCOLOR" >> $LOG    
	sudo apt-get install libapache2-mod-php -y
fi

if dpkg -s php-mysql >/dev/null 2>&1; then
	echo -e "\n `date` $G PHP-Mysql se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G PHP-Mysql se encuentra instalado $NOCOLOR" >> $LOG             
else
    echo -e "\n `date`  $G Instalando PHP-Mysql $NOCOLOR"
	echo -e "\n `date`  $G Instalando PHP-Mysql $NOCOLOR" >> $LOG    
	sudo apt-get install php-mysql -y
fi

if dpkg -s php-mbstring >/dev/null 2>&1; then
	echo -e "\n `date` $G php-mbstring se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G php-mbstring se encuentra instalado $NOCOLOR" >> $LOG             
else
    echo -e "\n `date`  $G Instalando php-mbstring $NOCOLOR"
	echo -e "\n `date`  $G Instalando php-mbstring $NOCOLOR" >> $LOG    
	sudo apt-get install php-mbstring -y
fi

if dpkg -s php-zip >/dev/null 2>&1; then
	echo -e "\n `date` $G php-zip se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G php-zip se encuentra instalado $NOCOLOR" >> $LOG             
else
    echo -e "\n `date`  $G Instalando php-zip $NOCOLOR"
	echo -e "\n `date`  $G Instalando php-zip $NOCOLOR" >> $LOG    
	sudo apt-get install php-zip -y
fi

if dpkg -s php-gd >/dev/null 2>&1; then
	echo -e "\n `date` $G php-gd se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G php-gd se encuentra instalado $NOCOLOR" >> $LOG             
else
    echo -e "\n `date`  $G Instalando php-gd $NOCOLOR"
	echo -e "\n `date`  $G Instalando php-gd $NOCOLOR" >> $LOG    
	sudo apt-get install php-gd -y
fi

if dpkg -s php-json >/dev/null 2>&1; then
	echo -e "\n `date` $G php-json se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G php-json se encuentra instalado $NOCOLOR" >> $LOG             
else
    echo -e "\n `date`  $G Instalando php-json $NOCOLOR"
	echo -e "\n `date`  $G Instalando php-json $NOCOLOR" >> $LOG    
	sudo apt-get install php-json -y
fi

if dpkg -s php-curl >/dev/null 2>&1; then
	echo -e "\n `date` $G php-curl se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G php-curl se encuentra instalado $NOCOLOR" >> $LOG             
else
    echo -e "\n `date`  $G Instalando php-curl $NOCOLOR"
	echo -e "\n `date`  $G Instalando php-curl $NOCOLOR" >> $LOG    
	sudo apt-get install php-curl -y
fi

# Instalacion de Base de datos maria DB 
if dpkg -s mariadb-server >/dev/null 2>&1; then 
	echo -e "\n `date` $G Mariadb se encuentra instalado $NOCOLOR"
	echo -e "\n `date` $G Mariadb se encuentra instalado $NOCOLOR" >> $LOG
	sudo systemctl status mariadb
else    
    echo -e "\n `date` $G instalando Mariadb $NOCOLOR"
	echo -e "\n `date` $G instalando Mariadb $NOCOLOR" >> $LOG
	sudo apt install mariadb-server -y
	sudo systemctl start mariadb
	sudo systemctl enable mariadb
	sudo systemctl status mariadb
fi

#Creacion de usuarios en bd
echo -e $G "\n Configurando base de datos" $NOCOLOR

cat > db-load-script.sql <<-EOF
CREATE DATABASE devopstravel;
CREATE USER `echo ${DB_USER}`@'localhost' IDENTIFIED BY '`echo ${DB_PASS}`';
GRANT ALL PRIVILEGES ON *.* TO `echo ${DB_USER}`@'localhost';
FLUSH PRIVILEGES;
EOF

mysql < db-load-script.sql

# Validando versiones instaladas 
echo -e $G "\n Información del Sistema Operativo" $NOCOLOR
hostnamectl
echo -e $G "\n Version de Git" $NOCOLOR
git --version
git --version >> $LOG
echo -e $G "\n Version de curl" $NOCOLOR
curl --version
curl --version >> $LOG
echo -e $G " \n Version de apache2" $NOCOLOR
apache2 -v
apache2 -v >> $LOG
echo -e $G "\n Version de PHP" $NOCOLOR
php --version
php --version >> $LOG
echo -e $G "\n Version de MariaDB" $NOCOLOR
mariadb --version
mariadb --version >> $LOG


############################# STAGE 2: Build ########################################

echo -e "\n\n `date` $B Ejecutando STAGE 2: Build - Clonando Repositorio de aplicacion $NOCOLOR"
echo -e "\n\n  `date` $B Ejecutando STAGE 2: Build - Clonando Repositorio de aplicacion $NOCOLOR" >> $LOG

#Clonar el repositorio de la aplicación
#Validar si el repositorio de la aplicación no existe realizar un git clone. y si existe un git pull

if [ -d $REPO ] ; then
    echo -e " `date` $G El repositorio existe $NOCOLOR"
	echo -e " `date` $G El repositorio existe $NOCOLOR" >> $LOG
	pwd
    cd $REPO
	git pull
	  
else
    echo -e " `date` $G El repositorio no existe, iniciando clone $NOCOLOR"
	echo -e " `date` $G El repositorio no existe, iniciando clone $NOCOLOR" >> $LOG
    git clone $URL_REPO
	cd $REPO
fi

#Mover al directorio donde se guardar los archivos de configuración de apache

if git branch |grep $BRANCH >/dev/null 2>&1; then
    echo -e $G "Repositorio en rama $BRANCH"
    mv /var/www/html/index.html /var/www/html/index.html.bkp
	cp -r $PROYECTO/* /var/www/html/
else
    echo -e $R "El repo no esta en $BRANCH" $NOCOLOR
	git checkout $BRANCH #Ajuste particulpar para acceder al branch en donde esta la carpeta de la web
	mv /var/www/html/index.html /var/www/html/index.html.bck
	cp -r $PROYECTO/* /var/www/html/
fi

############################# STAGE 3: Deploy ########################################
echo -e $G "Cargando data y configurando aplicación $BRANCH" $NOCOLOR

mysql < $PROYECTO/database/devopstravel.sql
sed -i s/codeuser/$DB_USER/g /var/www/html/config.php
sed -i s/'""'/$DB_PASS/g /var/www/html/config.php

#Ajustar el config de php para que soporte los archivos dinamicos de php agreganfo index.php

sed -i s/DirectoryIndex\ index.html\ index.cgi\ index.pl\ index.php\ index.xhtml\ index.htm/DirectoryIndex\ index.php\ index.html\ index.cgi\ index.pl\ index.xhtml\ index.htm/g  /etc/apache2/mods-enabled/dir.conf
systemctl reload apache2

#Testear existencia del codigo de la aplicación
if curl localhost >/dev/null 2>&1; then
	echo -e $G "El codigo esta funcional $BRANCH" $NOCOLOR
else
	echo -e $R "No esta funcional el codigo $BRANCH" $NOCOLOR
fi

#Testear la compatibilidad -> ejemplo http://localhost/info.php
curl localhost/info.php
curl localhost/info.php >> $LOG
#Si te muestra resultado de una pantalla informativa php , estariamos funcional para la siguiente etapa.

############################# STAGE 4: Notify ########################################

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