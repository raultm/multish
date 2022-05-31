Multish

Comando que usa tmux y tmux-cssh para manejar multiples conexiones ssh al mismo tiempo

Para generación de paquete voy a seguir el post [How To Create a Basic Debian Package](https://betterprogramming.pub/how-to-create-a-basic-debian-package-927be001ad80) y [Create a Debian package using dpkg-deb tool](https://blog.knoldus.com/create-a-debian-package-using-dpkg-deb-tool/)

https://serverfault.com/questions/608379/debian-deb-package-replace-config-files


???
https://honk.sigxcpu.org/piki/projects/git-buildpackage/

La idea es tener el comando instalable como paquete y que gestione las posibles dependencias
- tmux
- tmux-cssh
- sshpass

al instalar tener por defecto en `/etc/multish/groups` los archivos de grupos a los que acceder.

# Instalación

En la carpeta donde hayas descargado el archivo .deb apt/apt-get install instala el paquete y las dependencias. Poner './' para que sepa que es un archivo local y no un paquete de los repositorios

```sh
wget https://github.com/raultm/multish/releases/download/v0.3.0/multish_0.3.0_all.deb
apt install ./multish_0.3.0_all.deb
```

Si usas dpkg debes ejecutar despues apt para instalar las dependencias y finalizar la instalación

```sh
dpkg -i multish_0.3.0_all.deb
apt-get -f install
```

# Uso

## Acceder a través de opciones de menú

Al invocar el siguient comando aparecerá listado de grupos, al seleccionar se abrirán las múltiples conexiones ssh

```sh
multish
```
## Acceso Directo por CLI Ruta Completa

Si recibe un parámetro comprueba si es un fichero (ruta completa) y lo trata como archivo de grupo 

```sh
multish /home/to/group/example
```
## Acceso Directo por CLI Ruta Relativa

Si recibe un parámetro y no es un ruta, comprueba si es nombre de un archivo de grupo de la carpeta `/etc/multish/groups` y lo trata

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
Nombre de archivo donde se guardarán los resultados [2022-05-31-21-31-49-discover-results]: 
Explorando 192.168.1.86/24. Los resultados se guardarán en 2022-05-31-21-31-49-discover-results. Espere a que termine el proceso...
Exploración Finalizada. Los resultados se han guardado en /etc/multish/group/network-discoveries/2022-05-31-21-31-49-discover-results
¿Quieres conectarte ahora a los equipos encontrados? y/n  [y]:
```

# Entrar sin contraseña en los equipos

Si deseas entrar en los ordenadores sin usar contraseña puede añadir tu clave rsa pública como servidor de confianza.

Una de las opciones multish será elegir un grupo, pedirá contraseña y copiará clave pública en los hosts, si el usuario no tuviera clave publica creada le preguntará si quiere crearla y ejecutará el comando necesario.



# Contruir el paquete .deb

```sh
dpkg-deb  -b . .
```

Una vez generado el paquete tan solo queda instalar donde se necesite


