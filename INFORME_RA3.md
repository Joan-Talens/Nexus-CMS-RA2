
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

