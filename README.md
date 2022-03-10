Multish

Comando que usa tmux y tmux-cssh para manejar multiples conexiones ssh al mismo tiempo

Para generación de paquete voy a seguir el post [How To Create a Basic Debian Package](https://betterprogramming.pub/how-to-create-a-basic-debian-package-927be001ad80) y [Create a Debian package using dpkg-deb tool](https://blog.knoldus.com/create-a-debian-package-using-dpkg-deb-tool/)


???
https://honk.sigxcpu.org/piki/projects/git-buildpackage/

La idea es tener el comando instalable como paquete y que gestione las posibles dependencias
- tmux
- tmux-cssh

al instalar tener por defecto en `/etc/multish/groups` los archivos de grupos a los que acceder.


Posibilidades

Por defecto mostrar los archivos de grupos
```sh
multish
```

Si recibe un parámetro comprobar si es un fichero (ruta completa) y tratarlo como archivo de grupo

```sh
multish /home/to/group/file
```

Si recibe un parámetro y no es un ruta, comprobar si es nombre de un archivo de grupo de la carpeta `/etc/multish/groups`

```sh
multish aulas
```

# Contruir el paquete .deb

```sh
dpkg-deb  -b . .
```

Una vez generado el paquete tan solo queda instalar donde se necesite


