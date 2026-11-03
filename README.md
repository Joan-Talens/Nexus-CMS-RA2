## Estructura de servicios
- **nginx**: Servidor web escuchando en el puerto `8080` (imagen `nginx:stable`).
- **wordpress**: Ejecución de PHP-FPM conectada a la base de datos (imagen `wordpress:7.1-php8.3-fpm`).
- **db**: Base de datos MariaDB (imagen `mariadb:11`).

## Instrucciones de despliegue

1. Clona este repositorio.
2. Rellena el archivo `.env` con tus contraseñas reales (el archivo `.env` está ignorado en Git por seguridad).
3. Levanta el servicio de base de datos para crear el usuario y la BD exclusiva de WordPress:
   ```bash
   docker compose up -d db
   docker compose exec db sh -c 'mariadb -u root -p"$MYSQL_ROOT_PASSWORD"'
