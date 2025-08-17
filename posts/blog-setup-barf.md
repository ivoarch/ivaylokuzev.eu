# Cómo he creado mi sitio web con barf

2024-11-26

Recientemente he descubierto [barf](https://barf.btxx.org/), un super sencillo generator de sitios web estaticos, que usa un unico archivo shell (sh), script con menos de < 170 líneas para hacer la magia.

Algunas caracteristicas mas destacables:

- Sin diseños de plantilla avanzados.
- Sin categorías y etiquetado.
- Sin opcion de hacer comentarios.
- Solo lo mas necesario, a la "suckless".

> Con **barf** los blogs son muy divertidos :)

He decidido de usar lo, para la creacion de mi sitio web y espacio blog, en los pasos de abajo vera como instalar y el funcionamento basico.

## Instalar las dependencias

Para Fedora/AlmaLinux:

```
$ sudo dnf install git cmake extra-cmake-modules rsync
```

Compilar MultiMarkdown:

```
$ git clone https://github.com/fletcher/MultiMarkdown-6.git
$ cd MultiMarkdown-6
$ sudo cmake . -DCMAKE_BUILD_TYPE=Release
$ sudo make
$ sudo make install
```

## Clonar el repositorio de barf

Descargar el repositorio, usando git:

```
$ git clone https://git.sr.ht/~bt/barf
```

## Configuraciones

### Editamos los archivos

- index.md
- header.html
- footer.html
- barf (editamos la variable `domain=` apuntando dentro noestro dominio para validar el feed)

No necesariamente, tambien podemos jugar con
el archivo `style.css` ubicado en el directorio `public/`, para darle un aspecto unico al noestro sitio web.

Para saber mas, recomiendo leer el [README](https://git.sr.ht/~bt/barf/tree/master/item/README.md). 

## Crear noestra primera publicacion

Todos las publicaciones tienen que ir al directorio `posts/` . 

Ejemplo: 

```
$ cd ~/barf/posts/
$ nano fisrt-post.md
```

Con el seguiente contenido:

```
# Primera publicacion

2024-11-26

Hola mundo!
```

Recreamos el sitio web de nuevo para aplicar los cambios .

```
$ make build
```

Felicidades, ya hemos creado noestro blog y noestra primera publicacion dentro!

## Alojando mi web

Requerimientos necesarios:

- [Caddy](https://caddyserver.com/)
- [Rsync](https://rsync.samba.org/)
- Un dominio - yo tengo el mio con [OVHcloud](https://www.ovhcloud.com/es-es/), despues de estar muchos años con [Gandi](https://www.gandi.net/es) .

En el servidor creamos el directorio `/var/www/ivaylokuzev.eu` (el directorio root donde estaran ubicados los archivos estaticos para el publico).

```
$ sudo mkdir -p /var/www/ivaylokuzev.eu
```

Sincronizar el directorio `build/` con el directorio root `/var/www/ivaylokuzev.eu`.

```
$ rsync -rv build/ /var/www/ivaylokuzev.eu
```

## Configuramos el DNS

Tenemos que apuntar un dominio a la dirección IP, lo hice con la siguiente configuración:

| Domain | Type | TTL | Target |
| ------ | ---- | --- | ------ |
| ivaylokuzev.eu | A | default | 123.456.78.90 |

## Configurando Caddy

Vamos a configurar [Caddy](https://caddyserver.com/) para que sirva esos archivos. 

```
$ sudo nano /etc/caddy/Caddyfile
```

Copiamos lo seguiente:

```
ivaylokuzev.eu {
   tls email@example.com
   encode gzip zstd
   root * /var/www/ivaylokuzev.eu
   file_server
}
```

La línea tls habilita HTTPS automático. Caddy obtendrá y renovará los certificados SSL para usted con cero configuración o mantenimiento.

Reiniciamos caddy:

```
$ sudo systemctl restart caddy
```

Y asi de facil y gratis, mi sitio se servira de forma segura a traves de HTTPS! 
