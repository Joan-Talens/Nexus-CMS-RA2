
# INFORME RA3 — Usuarios, perfiles y módulos

## 1. Configuración inicial

Se creó la rama `ra3-admin` para realizar la práctica.

Se añadieron las carpetas `logs`, `datos`, `backups` y `scripts`.

Se modificó el archivo `docker-compose.yml` para añadir el registro de logs de Nginx y el servicio WP-CLI.

También se creó el script `wp` para ejecutar comandos de WordPress desde la terminal.

## 2. Usuarios y perfiles

Se crearon los siguientes usuarios:

| Usuario | Rol |
|---|---|
| coord.web | Editor |
| profe.redes | Autor |
| alumna.fct | Colaborador |
| familia.garcia | Suscriptor |
| revisor.fp | Revisor |

Se comprobó que cada perfil dispone de diferentes permisos.

- **Colaborador:** puede crear entradas y enviarlas a revisión, pero no publicarlas ni subir archivos.
- **Editor:** puede revisar y publicar entradas de otros usuarios.
- **Autor:** puede publicar sus propias entradas, pero no editar las de otros usuarios.
- **Suscriptor:** solamente puede acceder a su perfil.
- **Revisor:** puede editar entradas, pero no tiene permisos de borrado.

## 3. Rol personalizado Revisor

Se creó el rol `revisor` copiando los permisos del Editor.

Posteriormente se eliminaron nueve capacidades relacionadas con el borrado de entradas, páginas y categorías.

Se creó el usuario `revisor.fp` y se comprobó que podía editar contenido, pero no eliminarlo.

También se verificó que el registro de nuevos usuarios está desactivado (`users_can_register = 0`) y que el rol predeterminado es `subscriber`.

## 4. Comparación y selección de plugins

### Plugins de cookies

Se compararon dos opciones:

| Plugin | Instalaciones activas | Valoración |
|---|---:|---:|
| Complianz GDPR/CCPA Cookie Consent Banner | Más de 1 millón | No disponible |
| Cookie Notice | 800.000 | 96 % |

**Elección:** Cookie Notice (`cookie-notice`).

**Motivo:** Se eligió por ser una opción sencilla para configurar el aviso de cookies.

### Almacenamiento de mensajes

Se seleccionó Flamingo (`flamingo`), con 800.000 instalaciones activas y una valoración del 84 %.

Permite almacenar los mensajes recibidos mediante Contact Form 7 y consultarlos desde el panel de administración.

## 5. Formulario de contacto y Flamingo

Se configuró el formulario de Contact Form 7 añadiendo un campo obligatorio llamado `ciclo`, con las opciones ASIR, DAW y SMR.

En los ajustes adicionales se añadió:

`skip_mail: on`

El formulario se colocó en la página Contacto.

Se realizó una prueba de envío y se comprobó que el mensaje aparecía correctamente en Flamingo.

## 6. Aviso de cookies

Se instaló y activó Cookie Notice.

Se configuró el texto del aviso en español y se habilitaron los botones para aceptar y rechazar las cookies.

Se comprobó que el aviso aparecía en la página pública mediante una ventana privada.

## 7. Historial de actividad

Se instaló y activó Simple History.

Se comprobó desde el panel de administración que registra las acciones y modificaciones realizadas en WordPress.

## 8. Limpieza de plugins

Se eliminaron los plugins Akismet y Hello Dolly, que estaban inactivos.

Se conservaron activos:

- Contact Form 7
- Flamingo
- Cookie Notice
- Simple History
- Limit Login Attempts Reloaded

## 9. Conclusión

Con esta práctica se ha aprendido a gestionar usuarios y permisos de WordPress, crear roles personalizados, instalar y configurar plugins y comprobar el funcionamiento de los formularios, el almacenamiento de mensajes y el historial de actividad.

## 10. Comparación de plugins para R1 y R3

### R1. Formularios de contacto y almacenamiento

Se compararon las siguientes opciones:

| Plugin | Instalaciones activas | Valoración | Última actualización |
|---|---:|---:|---|
| Contact Form 7 | 10.000.000 | 80 | 10/11/2026 |
| Forminator | 600.000 | 96 | 02/11/2026 |
| CFDB7 | 600.000 | 100 | 09/10/2026 |

**Elección: Contact Form 7 + Flamingo.**

Se eligió esta combinación porque permite crear formularios personalizados y almacenar los mensajes recibidos directamente en WordPress.

### R3. Registro de actividad de usuarios

Se compararon las siguientes opciones:

| Plugin | Instalaciones activas | Valoración | Última actualización |
|---|---:|---:|---|
| WP Activity Log | 300.000 | 94 | 05/11/2026 |
| Aryo Activity Log | 200.000 | 86 | 28/10/2026 |
| Simple History | 300.000 | 98 | 17/10/2026 |

**Elección: Simple History.**

Se eligió por su valoración de 98 sobre 100 y porque permite consultar desde el panel de WordPress las acciones realizadas por los usuarios.

## 11. Copias de seguridad y restauración

### 11.1. Creación de copias de seguridad

Se creó el script `scripts/backup.sh` para automatizar las copias de seguridad del proyecto.

El script realiza las siguientes operaciones:

- Genera una copia de la base de datos MariaDB en formato `.sql.gz`.
- Comprime la carpeta `wp-content` de WordPress en formato `.tar.gz`.
- Comprueba la integridad de los archivos generados.
- Conserva las últimas 7 copias de seguridad.

Las copias se almacenan en el directorio `backups/`.

Para ejecutar el script:

```bash
./scripts/backup.sh
```

Se comprobó su funcionamiento correctamente. Como prueba, se generaron los archivos correspondientes a la copia `20261118-133015`.

### 11.2. Restauración de copias

Se creó el script `scripts/restore.sh` para recuperar la base de datos y los archivos de WordPress a partir de una copia anterior.

El script permite consultar las copias disponibles y seleccionar la fecha que se quiere restaurar. Antes de realizar la operación, comprueba la integridad de los archivos y solicita confirmación al usuario.

Para restaurar una copia:

```bash
./scripts/restore.sh 20261118-133015
```

Durante las pruebas se corrigió el comando de extracción del archivo de `wp-content`, permitiendo completar correctamente la restauración.

### 11.3. Prueba de recuperación

Para comprobar que el sistema de copias funciona correctamente, se realizó una prueba controlada:

1. Se creó una copia de seguridad.
2. Se eliminó la entrada de WordPress con ID 60, titulada «Mi primera entrada como autor».
3. Se eliminó el plugin Flamingo.
4. Se comprobó que ambos elementos habían desaparecido.
5. Se ejecutó el script de restauración utilizando la copia `20261118-133015`.
6. Se comprobó que la entrada ID 60 volvió a aparecer.
7. Se verificó que Flamingo volvió a estar instalado y activo.

La prueba finalizó correctamente, demostrando que se pueden recuperar tanto los datos de la base de datos como los archivos de WordPress.

### 11.4. Protección de las copias

Se añadió `backups/` al archivo `.gitignore` para evitar que las copias de seguridad se publiquen en GitHub.

El archivo `.env` se mantiene separado para proteger las credenciales de acceso.

En GitHub Codespaces las copias se ejecutan manualmente, ya que el entorno puede detenerse. Se recomienda descargar periódicamente los archivos de seguridad.

La programación automática mediante `cron` se realizará en el equipo del aula.

## 12. Conclusión de la práctica RA3

En esta práctica se ha trabajado con la administración de WordPress, la gestión de usuarios y roles, la instalación de plugins, el control de actividad y la configuración de copias de seguridad.

También se ha comprobado mediante una prueba real que es posible recuperar una entrada eliminada y un plugin desinstalado utilizando los scripts desarrollados.
