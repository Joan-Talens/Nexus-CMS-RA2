#!/usr/bin/env bash
# =====================================================================
# restore.sh — Restauración de WordPress (RA3 · práctica 2)
#
# Uso:
#   ./scripts/restore.sh                 -> mostrar copias disponibles
#   ./scripts/restore.sh AAAAMMDD-HHMMSS -> restaurar una copia concreta
# =====================================================================

set -euo pipefail

cd "$(dirname "$0")/.."

DESTINO="backups"

# Si no se indica fecha, mostrar las copias disponibles
if [ "$#" -eq 0 ]; then
    echo "Copias de seguridad disponibles:"
    for f in "$DESTINO"/db_*.sql.gz; do
        [ -e "$f" ] || continue
        fecha="${f##*/db_}"
        fecha="${fecha%.sql.gz}"
        if [ -f "$DESTINO/wp-content_$fecha.tar.gz" ]; then
            echo "  $fecha"
        fi
    done
    echo
    echo "Uso: ./scripts/restore.sh AAAAMMDD-HHMMSS"
    exit 0
fi

if [ "$#" -ne 1 ]; then
    echo "Uso: ./scripts/restore.sh AAAAMMDD-HHMMSS" >&2
    exit 1
fi

FECHA="$1"

if [[ ! "$FECHA" =~ ^[0-9]{8}-[0-9]{6}$ ]]; then
    echo "ERROR: formato de fecha incorrecto." >&2
    exit 1
fi

F_DB="$DESTINO/db_$FECHA.sql.gz"
F_WP="$DESTINO/wp-content_$FECHA.tar.gz"

# Comprobar que existen los dos archivos
if [ ! -f "$F_DB" ] || [ ! -f "$F_WP" ]; then
    echo "ERROR: no se encuentra la copia completa de $FECHA." >&2
    exit 1
fi

# Comprobar integridad de los archivos
echo "Comprobando los archivos..."
gzip -t "$F_DB" "$F_WP"

TABLAS="$(gunzip -c "$F_DB" | grep -c 'CREATE TABLE' || true)"
if [ "$TABLAS" -eq 0 ]; then
    echo "ERROR: el volcado SQL no contiene tablas." >&2
    exit 1
fi

if ! tar -tzf "$F_WP" | awk '$0 == "wp-content/" {found=1} END {exit !found}'; then
    echo "ERROR: el archivo no contiene wp-content." >&2
    exit 1
fi

# Comprobar que los servicios están arrancados
for servicio in db wordpress; do
    if ! docker compose ps --status running --services | grep -qx "$servicio"; then
        echo "ERROR: el servicio '$servicio' no está en marcha." >&2
        echo "Ejecuta: docker compose up -d"
        exit 1
    fi
done

echo
echo "ATENCIÓN: vas a restaurar la copia $FECHA."
echo "Se sobrescribirá la base de datos y la carpeta wp-content actual."
echo "Tablas encontradas en el volcado: $TABLAS"
echo
read -r -p 'Escribe SI para confirmar la restauración: ' CONFIRMACION

if [ "$CONFIRMACION" != "SI" ]; then
    echo "Restauración cancelada."
    exit 0
fi

# 1. Restaurar la base de datos
echo "-> Restaurando la base de datos..."
docker compose exec -T db sh -c '
    : "${WP_DB_USER:?falta WP_DB_USER}" \
      "${WP_DB_PASSWORD:?falta WP_DB_PASSWORD}" \
      "${WP_DB_NAME:?falta WP_DB_NAME}"
    exec mariadb -u"$WP_DB_USER" -p"$WP_DB_PASSWORD" "$WP_DB_NAME"' \
    < <(gzip -dc "$F_DB")

# 2. Sustituir wp-content
echo "-> Restaurando wp-content..."
gzip -dc "$F_WP" |
    docker compose exec -T wordpress sh -c \
    'rm -rf /var/www/html/wp-content && tar -xf - -C /var/www/html'

echo
echo "OK. Restauración de $FECHA completada."
