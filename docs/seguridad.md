# RA2 - Seguridad del gestor WordPress

## Comprobaciones iniciales y finales

| Comprobación | Antes | Después |
|---|---|---|
| Cabecera Server de Nginx | Mostraba `nginx/1.30.6` | Muestra `nginx`, sin versión |
| Acceso a `xmlrpc.php` | Respondía `405` a la petición HEAD | Bloqueado con `403 Forbidden` |
| Ejecución de PHP en uploads | El archivo de prueba devolvía `2` | Bloqueado con `403 Forbidden` |
| Acceso a `wp-config.php` | No comprobado inicialmente | Bloqueado con `403 Forbidden` |

## Medidas de seguridad aplicadas

- Se ocultó la versión de Nginx mediante `server_tokens off`.
- Se añadieron las cabeceras `X-Content-Type-Options` y `X-Frame-Options`.
- Se bloqueó el acceso a `xmlrpc.php` y `wp-config.php`.
- Se impidió la ejecución de archivos PHP dentro de la carpeta de subidas.
- Se desactivó la edición de archivos PHP desde el panel de WordPress mediante `DISALLOW_FILE_EDIT`.
- Se creó un usuario con el rol Editor para las tareas de publicación.
- Se cambió el nombre público del administrador para que no coincidiera con el nombre de acceso.
- Se instaló y activó Limit Login Attempts Reloaded. Se comprobó que bloquea temporalmente los accesos tras varios intentos fallidos.
- Se revisaron las actualizaciones disponibles de WordPress y sus componentes.

## Conclusión

Se han aplicado varias medidas para reducir la exposición del servidor Nginx y del gestor WordPress. Las comprobaciones finales confirmaron que la versión de Nginx queda oculta y que los archivos sensibles y los PHP de la carpeta de subidas no son accesibles.
