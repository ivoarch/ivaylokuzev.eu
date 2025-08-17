# Politica de privacidad

Este sitio web estático, no tiene javascript, ni cookies y otros rastreadores, como puede comprobar [aqui](https://themarkup.org/blacklight?url=ivaylokuzev.eu&device=desktop&location=eu&force=false).
Este sitio intenta recopilar datos mínimos sobre los visitantes.
Estos datos me sirven para saber el número de veces que se leen mis artículos, el numero de visitores unicos por dia, desde que sistema operativo visitan mi sitio, que navegador web usan,
cuántos visitantes están disfrutando de mi sitio web.

Las direcciónes IP de los visitantes estan
enmascarados usando un filter `ip_mask` de mi servidor web [Caddy](https://caddyserver.com/), para que oculta una parte de la IP de manera que analizando mi sitio web, no pueda saber la IP completa de los visitantes, conservando su privacidad .  

Por el interés de la privacidad del usuario, y mantener la cantidad de datos a un mínimo absoluto, tambien he configurado la rotación de registros,  reduciendo el tiempo de vida de los ficheros, para que no sigan acumolandose en mi servidor.  Los registros se borraran automaticamente diariamente .

La parte importante de esta configuracion:

```
ivaylokuzev.eu {
...
   log {
        output file "/var/log/caddy/access-www-ivaylokuzev-eu.log" {
        roll_size 10MiB
        roll_keep_for 24h
   }
        format filter {
            wrap json
            fields {
                request>remote_ip ip_mask {
                    ipv4 16
                    ipv6 32
                }
             }
        }
    }
}
```

### Explicacion

- `ipv4 16` enmascara los últimos 16 bits de las direcciones **IPv4**

```
192.168.20.100 => 192.168.20.0
```

- `ipv6 32` enmascara los últimos 32 bits de las direcciones IPv6.

```
2a03:2880:2110:df07:face:b00c::1 => 2a03:2880:2110:df07::
```

- `roll_size 10MiB` es el tamaño maximo de del registro.
- `roll_keep_for 24h` es el tiempo maximo que se mantiene en el sistema este registro.

## Como analizo mi sitio web

Para analizar mi sitio web, utilizo [GoAccess](https://goaccess.io/),  un analizador de registros web en tiempo real de **código abierto** y un visor interactivo que se ejecuta en un terminal en sistemas *nix o a través de un navegador web.

Lo que hace interesante a GoAccess, es que genera análisis relativamente detallados basados exclusivamente en los registros de acceso de un servidor web, como [Caddy](https://caddyserver.com/), en mi caso.

Para analizar mis registros de `caddy`, prefiero y uso `goaccess` solo desde la linea de comandos.

Ejecutando el siguente comando:

```
$ sudo goaccess /var/log/caddy/access-www-ivaylokuzev-eu.log --log-format=CADDY
```

![](/public/images/IMG_20250212_095744.jpg)

## Politica de privacidad de los subdominios

Al contrario de mi sitio web `ivaylokuzev.eu`, todos mis subdominios `*.ivaylokuzev.eu` que uso para alojar otros servicios, SI recopilan las direcciones IP completas.
Esto me permite utilizar herramientas como `fail2ban` para bloquear direcciones IP que intentan forzar mi servidor, normalmente estos ataques provienen de (bots).

## Terceros

### Hetzner

**Hetzner Online GmbH ("Hetzner")**, proporciona el servidor para los servicios que alojo, y se encuentra en Falkenstein, Alemania (EU).
La política de privacidad de Hetzner se puede consultar [aquí](https://www.hetzner.com/legal/privacy-policy/).

### Enlaces externos

Este sitio contiene enlaces a sitios web de terceros ("enlaces externos"). Dado que el contenido de estos sitios web no está bajo mi control, no puedo asumir ninguna responsabilidad por dicho contenido externo. 
Los administradores de los sitios web enlazados serán siempre responsables de su contenido y de la exactitud de la información facilitada. 
En el momento en que coloqué los enlaces no era reconocible ningún contenido ilegal.

## Términos y condiciones de uso

No es necesario aceptar ningún termino o condición de uso para visitar, leer o copiar algún contenido de este sitio web.
Todo el contenido publicado en este sitio web está bajo [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/deed.es), a menos que se especifique lo contrario.

El [codigo](https://git.sr.ht/~ivaylokuzev/ivaylokuzev.eu) de este sitio web es [MIT](https://git.sr.ht/~ivaylokuzev/ivaylokuzev.eu/blob/main/LICENSE).

