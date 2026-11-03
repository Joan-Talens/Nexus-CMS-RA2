# Personalización de Nexus CMS

## Tema

- **Tema utilizado:** Skewart
- **Motivo de elección:** Se ha elegido por su diseño moderno y porque encaja con la temática tecnológica de Nexus CMS.
- **Comprobación:** Se ha cambiado temporalmente a otro tema y se ha comprobado que el contenido de WordPress se mantiene.

## Plugin instalado

- **Nombre:** Contact Form 7
- **Motivo:** Permite añadir un formulario de contacto para que los visitantes puedan enviar mensajes desde la web.
- **Uso:** Se ha integrado en la página Contacto y se ha comprobado su funcionamiento.

## Estructura del contenido

### Páginas
- Inicio
- Sobre el proyecto
- Tecnologías (página hija de Sobre el proyecto)
- Contacto

### Entradas
Se han creado tres entradas, organizadas en las categorías:
- Novedades
- Tutoriales

### Menú
El menú principal contiene Inicio, Sobre el proyecto y Contacto.
Tecnologías aparece como submenú de Sobre el proyecto.

## Página de inicio

Se ha configurado Inicio como página estática principal del sitio.

## Configuración de PHP

Se ha creado el archivo `config/uploads.ini` con los siguientes límites:

- `upload_max_filesize = 64M`
- `post_max_size = 64M`
- `memory_limit = 256M`

La configuración se monta en el contenedor de WordPress mediante `docker-compose.yml`.
Se ha comprobado que PHP aplica los límites y que WordPress muestra un máximo de subida de 64 MB.

## Medios

Se han subido tres imágenes a la biblioteca de medios de WordPress.
Se ha comprobado que se almacenan en el volumen persistente dentro de la carpeta de subidas, organizadas por año y mes.
