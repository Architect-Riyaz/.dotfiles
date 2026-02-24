alias dcb="docker compose up -d --build --force-recreate"

if [ -z "${DOCKER_APPS_DATA_PATH+x}" ]; then
  export DOCKER_APPS_DATA_PATH="$HOME/apps/docker_apps"
fi

# Ensure base path exists
mkdir -p "$DOCKER_APPS_DATA_PATH"

# ==============================
# Helper: Wait for TCP port
# ==============================
wait_for_port() {
  local HOST=$1
  local PORT=$2
  local SERVICE_NAME=$3
  local TIMEOUT=${4:-30}

  echo "Waiting for $SERVICE_NAME to be ready on $HOST:$PORT ..."

  for ((i=1; i<=TIMEOUT; i++)); do
    if nc -z "$HOST" "$PORT" >/dev/null 2>&1; then
      echo "$SERVICE_NAME is ready."
      return 0
    fi
    sleep 1
  done

  echo "ERROR: $SERVICE_NAME did not become ready within ${TIMEOUT}s."
  return 1
}

# ==============================
# pgAdmin
# ==============================
docker_pgadmin() {
  local PORT=${1:-5050}
  local APP_PATH="$DOCKER_APPS_DATA_PATH/pgadmin"

  mkdir -p "$APP_PATH"
  docker rm -f pgadmin >/dev/null 2>&1

  docker run -d \
    --name pgadmin \
    --restart unless-stopped \
    -p ${PORT}:80 \
    -e PGADMIN_DEFAULT_EMAIL=admin@example.com \
    -e PGADMIN_DEFAULT_PASSWORD=strongpassword \
    -v "$APP_PATH":/var/lib/pgadmin \
    dpage/pgadmin4

  # Check container running
  if ! docker ps --filter "name=^pgadmin$" --filter "status=running" | grep -q pgadmin; then
    echo "ERROR: pgAdmin container is not running."
    return 1
  fi

  # Wait for service readiness
  wait_for_port "localhost" "$PORT" "pgAdmin"
}

# ==============================
# Redis
# ==============================
docker_redis() {
  local PORT=${1:-6379}
  local APP_PATH="$DOCKER_APPS_DATA_PATH/redis"

  mkdir -p "$APP_PATH"
  docker rm -f redis >/dev/null 2>&1

  docker run -d \
    --name redis \
    --restart unless-stopped \
    -p ${PORT}:6379 \
    -v "$APP_PATH":/data \
    redis:alpine \
    redis-server --appendonly yes

  # Check container running
  if ! docker ps --filter "name=^redis$" --filter "status=running" | grep -q redis; then
    echo "ERROR: Redis container is not running."
    return 1
  fi

  # Wait for service readiness
  wait_for_port "localhost" "$PORT" "Redis"
}

# ==============================
# DBeaver (Web)
# ==============================
docker_dbeaver() {
  local PORT=${1:-8978}
  local APP_PATH="$DOCKER_APPS_DATA_PATH/dbeaver"

  mkdir -p "$APP_PATH"
  docker rm -f dbeaver >/dev/null 2>&1

  docker run -d \
    --name dbeaver \
    --restart unless-stopped \
    -p ${PORT}:8978 \
    -v "$APP_PATH":/opt/dbeaver/workspace \
    dbeaver/cloudbeaver:latest

  if ! docker ps --filter "name=^dbeaver$" --filter "status=running" | grep -q dbeaver; then
    echo "ERROR: DBeaver container is not running."
    return 1
  fi

  wait_for_port "localhost" "$PORT" "DBeaver"
}
