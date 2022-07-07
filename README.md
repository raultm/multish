Multish

Comando que usa tmux y tmux-cssh para manejar multiples conexiones ssh al mismo tiempo



al instalar tener por defecto en `/etc/multish/groups` los archivos de grupos a los que acceder.

# Instalación

En la carpeta donde hayas descargado el archivo .deb apt/apt-get install instala el paquete y las dependencias. Poner './' para que sepa que es un archivo local y no un paquete de los repositorios

```sh
wget https://github.com/raultm/multish/releases/download/v1.2.2/multish_1.2.2_all.deb
sudo apt install ./multish_1.2.2_all.deb
```

# Uso

## Acceder a través de opciones de menú

Al invocar el siguient comando aparecerá listado de grupos, al seleccionar se abrirán las múltiples conexiones ssh

```sh
multish
```

Ejemplo de Salida
```
$ multish

Create a multiple ssh connection to group
-----------------------------------------
Create a multiple ssh connection to group
-----------------------------------------
 1) /etc/multish/group/network-discoveries/20220603-101155-discover-results
 2) /etc/multish/group/network-discoveries/demo
 3) /etc/multish/group/pilar/salaprofesores
 4) /etc/multish/group/pilar/infolab
 5) /etc/multish/group/pilar/siatics
 6) /etc/multish/group/general/servidores-principales
 7) /etc/multish/group/extremadura/salaprofesores
 8) /etc/multish/group/extremadura/infolab
 9) Find hosts with port 22 open in network
10) Copy SSH public key to group
11) Wake Up Group
12) Get Groups from Server
13) Quit
Select Option:
```

## Conexión Múltiple SSH por CLI usando Ruta Completa

Si recibe un parámetro comprueba si es un fichero (ruta completa) y lo trata como archivo de grupo realizando automáticamente la conexión

```sh
multish /home/to/group/example
```
## Conexión Múltiple SSH por CLI usando Ruta Relativa

Si recibe un parámetro y no es un ruta, comprueba si es nombre de un archivo de grupo de la carpeta `/etc/multish/groups` realizando automáticamente la conexión

```sh
multish example
```


# Buscar equipos en la red

En algunas ocasiones nos va a interesar montar una red local y conectar varios equipos a esa red para una configuración general.

Se ha añadido una opción que buscar en la red determinar equipos con el puerto 22 abierto, los equipos encontrados se guardan en `/etc/multish/group/network-discoveries` con el nombre que hayas seleccionado.

Tras las búsqueda tambien te pregunta si deseas realizar una conexión multish automáticamente

Ejemplo de comando
```
Define la red que quieres explorar [192.168.1.86/24]: 
Nombre de archivo donde se guardarán los resultados [20220601-095559-discover-results]: 
Nombre de usuario con el que te quiere conectar a esos equipos [root]: 

Explorando 192.168.1.86/24. Los resultados se guardarán en 20220601-095559-discover-results. Espere a que termine el proceso...

Exploración Finalizada. Se han encontrado 2 equipos con el puerto 22 abierto.
Los resultados se han guardado en /etc/multish/group/network-discoveries/20220601-095559-discover-results

¿Quieres conectarte ahora a los equipos encontrados? y/n  [y]:
```

# Entrar sin contraseña en los equipos

Si deseas entrar en los ordenadores sin usar contraseña puede añadir tu clave rsa pública como servidor de confianza.

Una de las opciones multish será elegir un grupo, pedirá contraseña y copiará clave pública en los hosts, si el usuario no tuviera clave publica creada le preguntará si quiere crearla y ejecutará el comando necesario.

# TMUX Avanzado

Si ejecutas el comando multish y detecta que tu usuario no tiene el archivo `~/.tmux.conf` te añadirá uno con dos opciones

- Uso de ratón cuando estés en interfaz gráfica
- Sincronizar/Desincronizar los pane con la combinación de teclas <kbd>Ctrl</kbd> + <kbd>B</kbd> -> <kbd>Ctrl</kbd> + <kbd>V</kbd>, si están sincronizados y haces esas dos combinaciones se desincronizará, si vuelves a ejecutar las dos combinaciones volverán a sincronizarse.

```
set -g mouse on        #For tmux version 2.1 and up

# synchronize all panes in a window
# If sync   Ctrl+B->Ctrl+V desync
# If desync Ctrl+B->Ctrl+V sync
bind C-V set-window-option synchronize-panes
```

# Mandar WOL (Wake on Lan)

Se ha añadido la opción de mandar mensajes de wake on lan para un grupo determinado

# Copiar los datos de grupo desde una conexión remota

Haciendo uso de los valores cargados a través de `/etc/multish/.env`
  - SSHUSER
  - SSHMACHINE
  - SSHGROUPSFOLDER

Se pueden copiar los datos a tu carpeta local `/etc/multish/group`

Como hay posibilidad de que se sobreescriban datos te pregunta antes de proceder

# Contruir el paquete .deb

```sh
dpkg-deb  -b . .
```

Para generación de paquete voy a seguir el post [How To Create a Basic Debian Package](https://betterprogramming.pub/how-to-create-a-basic-debian-package-927be001ad80) y [Create a Debian package using dpkg-deb tool](https://blog.knoldus.com/create-a-debian-package-using-dpkg-deb-tool/)

https://serverfault.com/questions/608379/debian-deb-package-replace-config-files


???
https://honk.sigxcpu.org/piki/projects/git-buildpackage/

La idea es tener el comando instalable como paquete y que gestione las posibles dependencias
- tmux
- tmux-cssh
- sshpass
- nmap

Una vez generado el paquete tan solo queda instalar donde se necesite


