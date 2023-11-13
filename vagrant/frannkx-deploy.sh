#!/bin/bash/
#Banner
echo '
##############################################################
#   ______                                  _                #
#  |  ____|                                | |               #
#  | |__     _ __    __ _   _ __    _ __   | | __ __  __     #
#  |  __|   | !__|  / _` | | !_ \  | !_ \  | |/ / \ \/ /     #
#  | |      | |    | (_| | | | | | | | | | |   <   >  <      #
#  |_|      |_|     \__,_| |_| |_| |_| |_| |_|\_\ /_/\_\     #
#                                                            #
######## Bienvenido al deploy de Francisco Paredes ###########         
'                                                                                                             

#### Declaracion de variables requeridas
# Repositorio
REPO=https://github.com/roxsross/devops-static-web.git
#REPO=https://github.com/roxsross/bootcamp-devops-2023.git
PROYECTO=devops-static-web
#PROYECTO=app-295devops-travel
DISCORD="https://discord.com/api/webhooks/1169002249939329156/7MOorDwzym-yBUs3gp0k5q7HyA42M5eYjfjpZgEwmAx1vVVcLgnlSh4TmtqZqCtbupov"
R='\033[0;31m'   #'0;31' is Red's ANSI color code
G='\033[0;32m'   #'0;32' is Green's ANSI color code
Y='\033[1;32m'   #'1;32' is Yellow's ANSI color code
B='\033[0;34m'   #'0;34' is Blue's ANSI color code
NOCOLOR='\033[0m'
LOG=`date +%e-%m-%Y-%T`.log

echo `date` $B Ejecutando STAGE 1: Init - Instalando paquetes necesarios $NOCOLOR 
echo `date` $B Ejecutando STAGE 1: Init - Instalando paquetes necesarios $NOCOLOR >> $LOG

#Instalacion de paquetes en el sistema operativo ubuntu: [apache, php, mariadb, git, curl, etc]
#Validación si esta instalado los paquetes o no , de manera de no reinstalar
#Habilitar y Testear instalación de los paquetes

# validar usuario root

# Actualizando versiones de paquetes 
sudo apt-get update -y

# Instalando Git
if dpkg -s git >/dev/null 2>&1; then
	echo `date` $G Git se encuentra instalado $NOCOLOR
	echo `date` $G Git se encuentra instalado $NOCOLOR >> $LOG
else
    echo `date` $G instalando git $NOCOLOR
	echo `date` $G instalando git $NOCOLOR >> $LOG
	sudo apt install git -y >> $LOG
	git --version >> $LOG
fi

# Instalando curl
if dpkg -s curl >/dev/null 2>&1; then
	echo `date` $G curl se encuentra instalado $NOCOLOR 
	echo `date` $G curl se encuentra instalado $NOCOLOR >> $LOG
else
    echo `date` $G Instalando curl $NOCOLOR
	echo `date` $G Instalando curl $NOCOLOR >> $LOG
	sudo apt-get install curl -y >> $LOG
	curl --version >> $LOG
fi

# Instalando Apache2
if dpkg -s apache2 >/dev/null 2>&1; then
	echo `date` $G Apache2 se encuentra instalado $NOCOLOR 
	echo `date` $G Apache2 se encuentra instalado $NOCOLOR >> $LOG
else
    echo `date` $G Instalando Apache2 $NOCOLOR
	echo `date` $G Instalando Apache2 $NOCOLOR >> $LOG
	sudo apt-get install apache2 -y >> $LOG
	sudo apt-get install libapache2-mod-php -y >> $LOG
	apache2 -v
	sudo systemctl enable apache2
	#sudo systemctl status apache2
fi


# Instalando PHP
if dpkg -s php >/dev/null 2>&1; then
	echo `date` $G PHP se encuentra instalado $NOCOLOR
	echo `date` $G PHP se encuentra instalado $NOCOLOR >> $LOG             
else
    echo `date`  $G Instalando PHP $NOCOLOR
	echo `date`  $G Instalando PHP $NOCOLOR >> $LOG    
	sudo apt-get install php -y
	php --version
fi

# Instalacion de Mysql 
if dpkg -s mysql-server >/dev/null 2>&1; then 
	echo `date` $G MySql se encuentra instalado $NOCOLOR
	echo `date` $G MySql se encuentra instalado $NOCOLOR >> $LOG
else    
    echo `date` $G instalando Mysql $NOCOLOR
	echo `date` $G instalando Mysql $NOCOLOR >> $LOG
	sudo apt install mysql-server -y
	#sudo systemctl status mysql.service
fi

echo `date` $B Ejecutando STAGE 2: Build - Clonando Repositorio de aplicacion $NOCOLOR
echo `date` $B Ejecutando STAGE 2: Build - Clonando Repositorio de aplicacion $NOCOLOR >> $LOG

#Clonar el repositorio de la aplicación
#Validar si el repositorio de la aplicación no existe realizar un git clone. y si existe un git pull
#Mover al directorio donde se guardar los archivos de configuración de apache /var/www/html/
#Testear existencia del codigo de la aplicación
#Ajustar el config de php para que soporte los archivos dinamicos de php agregando index.php
#Testear la compatibilidad -> ejemplo http://localhost/info.php
#Si te muestra resultado de una pantalla informativa php , estariamos funcional para la siguiente etapa.

if [ -d $PROYECTO ] ; then
    echo `date` $G El repositorio existe $NOCOLOR
	echo `date` $G El repositorio existe $NOCOLOR >> $LOG
    git pull  
else
    echo `date` $G El repositorio no existe, iniciando clone $NOCOLOR
	echo `date` $G El repositorio no existe, iniciando clone $NOCOLOR >> $LOG
    git clone $REPO
fi

cd $PROYECTO 
sudo mv * /var/www/html/

echo `date` $B Ejecutando STAGE 3: Deploy - Desplegando aplicación $NOCOLOR
echo `date` $B Ejecutando STAGE 3: Deploy - Desplegando aplicación $NOCOLOR >> $LOG

#Es momento de probar la aplicación, recuerda hacer un reload de apache y acceder a la aplicacion DevOps Travel
#Aplicación disponible para el usuario final.

 #w3m localhost

 echo `date` $B Ejecutando STAGE 4: Notify - Notificando estatus a Discord $NOCOLOR
 echo `date` $B Ejecutando STAGE 4: Notify - Notificando estatus a Discord $NOCOLOR >> $LOG

 #El status de la aplicacion si esta respondiendo correctamente o esta fallando debe reportarse via webhook al canal de discord #deploy-bootcamp
 #Informacion a mostrar : Author del Commit, Commit, descripcion, grupo y status

 #DISCORD="https://discord.com/api/webhooks/1169002249939329156/7MOorDwzym-yBUs3gp0k5q7HyA42M5eYjfjpZgEwmAx1vVVcLgnlSh4TmtqZqCtbupov"