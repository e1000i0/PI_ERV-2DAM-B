#!/usr/bin/env bash
# Prepara Garage de un solo nodo: asigna el diseño, crea el bucket y la clave S3.
# Es idempotente. Uso (desde la raíz del repositorio, con el servicio en marcha):
#   ./docker/garage/init.sh
set -euo pipefail

cd "$(dirname "$0")/../.."
set -a; . ./.env; set +a
: "${S3_BUCKET:?}" "${S3_ACCESS_KEY_ID:?}" "${S3_SECRET_ACCESS_KEY:?}"

garage() { MSYS_NO_PATHCONV=1 docker compose exec -T garage /garage "$@"; }

nodo=$(garage node id -q 2>/dev/null | head -1 | cut -d@ -f1)
if garage status | grep -q "NO ROLE ASSIGNED"; then
  garage layout assign -z dc1 -c 1GB "$nodo"
  garage layout apply --version 1
fi

garage bucket info "$S3_BUCKET" >/dev/null 2>&1 || garage bucket create "$S3_BUCKET"
garage key info "$S3_ACCESS_KEY_ID" >/dev/null 2>&1 || garage key import --yes -n hanger-api "$S3_ACCESS_KEY_ID" "$S3_SECRET_ACCESS_KEY"
garage bucket allow --read --write --owner "$S3_BUCKET" --key "$S3_ACCESS_KEY_ID"
echo "Garage listo: bucket $S3_BUCKET."
