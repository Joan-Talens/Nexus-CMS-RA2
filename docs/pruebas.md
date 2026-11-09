
# Pruebas de funcionamiento y rendimiento

## Pruebas de funcionamiento

| Prueba | Resultado | ¿Correcto? |
|---|---|---|
| Servicios en marcha | Nginx, WordPress y MariaDB funcionando | Sí |
| Sitio y panel | WordPress y wp-admin accesibles | Sí |
| Subida de ficheros | Imagen subida correctamente | Sí |
| Enlaces permanentes | Las entradas cargan correctamente | Sí |
| Persistencia (down/up) | Los datos se mantienen | Sí |
| Seguridad (403) | XML-RPC bloqueado por Nginx | Sí |

## Rendimiento

### Tiempos de respuesta en el aula

- Petición 1: 0,050677 s
- Petición 2: 0,032667 s
- Petición 3: 0,035186 s
- Petición 4: 0,035387 s
- Petición 5: 0,034965 s
- Media: 0,0378 s

### Memoria por contenedor

- Nginx: 13,7 MiB
- WordPress: 148,7 MiB
- MariaDB: 143 MiB

### Interpretación

La primera petición fue un poco más lenta que las demás. WordPress es el contenedor que más memoria consume, seguido de MariaDB. Nginx consume muy poca memoria.

## Publicación

- Dirección desde la que accedió mi compañero/a: red local, puerto 8080.
- Dirección pública en Codespaces:

https://organic-space-palm-tree-v6j74p6wjgjvfwxqw-8080.app.github.dev/

### Pruebas en Codespaces

- XML-RPC: HTTP 403 Forbidden.
- Petición 1: 0,145310 s
- Petición 2: 0,162246 s
- Petición 3: 0,152471 s
- Petición 4: 0,069358 s
- Petición 5: 0,158634 s
- Media: 0,1376 s

### Comparación

En local la página responde más rápido que en Codespaces. Esto puede deberse a la conexión a Internet y al proxy de GitHub. En los dos entornos XML-RPC está bloqueado correctamente.
