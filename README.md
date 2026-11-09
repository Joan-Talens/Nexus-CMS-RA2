
# Nexus CMS - RA2

Este proyecto consiste en montar una página web con WordPress utilizando Docker, Nginx y MariaDB. También se ha probado su funcionamiento en local y mediante GitHub Codespaces.

## 1. Servicios utilizados

- **Nginx:** servidor web que utiliza el puerto 8080.
- **WordPress:** gestor de contenidos para crear y administrar la página web.
- **MariaDB:** base de datos donde se guarda la información de WordPress.

## 2. Requisitos

Para utilizar el proyecto necesitamos:

- Docker.
- Docker Compose.
- Git.
- Una cuenta de GitHub para utilizar Codespaces.

## 3. Instalación desde cero

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/Joan-Talens/Nexus-CMS-RA2.git
   cd Nexus-CMS-RA2
   ```

2. Crear el archivo `.env`:

   ```bash
   nano .env
   ```

3. Introducir las siguientes variables con las contraseñas correspondientes:

   ```env
   MYSQL_ROOT_PASSWORD=tu_contraseña_root
   WP_DB_NAME=wp_db
   WP_DB_USER=wp_user
   WP_DB_PASSWORD=tu_contraseña_wordpress
   ```

4. Iniciar MariaDB:

   ```bash
   docker compose up -d db
   ```

5. Entrar en MariaDB:

   ```bash
   docker compose exec db mariadb -u root -p
   ```

6. Crear la base de datos y el usuario de WordPress:

   ```sql
   CREATE DATABASE wp_db;
   CREATE USER 'wp_user'@'%' IDENTIFIED BY 'tu_contraseña_wordpress';
   GRANT ALL PRIVILEGES ON wp_db.* TO 'wp_user'@'%';
   FLUSH PRIVILEGES;
   EXIT;
   ```

7. Iniciar todos los servicios:

   ```bash
   docker compose up -d
   ```

8. Comprobar que los contenedores funcionan:

   ```bash
   docker compose ps
   ```

9. Abrir WordPress desde el navegador:

   `http://localhost:8080`

## 4. Utilizar GitHub Codespaces

1. Abrir el repositorio en GitHub.
2. Seleccionar la rama `ra2-cms`.
3. Pulsar en Code y después en Codespaces.
4. Crear un nuevo Codespace.
5. Comprobar que Docker y Docker Compose funcionan.
6. Crear y configurar el archivo `.env`.
7. Iniciar MariaDB y crear la base de datos y el usuario.
8. Ejecutar:

   ```bash
   docker compose up -d
   ```

9. Abrir la pestaña PORTS.
10. Configurar el puerto 8080 como Public.
11. Acceder a WordPress mediante la dirección HTTPS proporcionada por GitHub.

## 5. Estructura del proyecto

- `docker-compose.yml`: configuración de los contenedores.
- `nginx/`: configuración de Nginx.
- `config/`: configuración adicional de PHP.
- `docs/`: documentación del proyecto.
  - `personalizacion.md`: personalización de WordPress.
  - `seguridad.md`: medidas de seguridad.
  - `pruebas.md`: pruebas de funcionamiento y rendimiento.

## 6. Documentación

Los documentos del proyecto son:

- [Personalización](docs/personalizacion.md)
- [Seguridad](docs/seguridad.md)
- [Pruebas y rendimiento](docs/pruebas.md)

## 7. Seguridad

El archivo `.env` contiene las contraseñas y está incluido en `.gitignore` para evitar que se publique en GitHub.

También se ha configurado Nginx para bloquear el acceso a `xmlrpc.php`.

## 8. Publicación

El proyecto se ha probado en local y en GitHub Codespaces.

En local se accede mediante el puerto 8080 y en Codespaces mediante una dirección HTTPS pública.
