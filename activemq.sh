#!/bin/bash

# load secrets to env-vars by:
[ -d "/run/secrets" ] && eval $(cd /run/secrets;awk '{printf "export %s=%s;\n",toupper(FILENAME),$0}' * | sed 's/-/_/g')

ACTIVEMQ_EXECUTABLE=bin/activemq
ACTIVEMQ_ARGS=console

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child" 2>/dev/null
}
trap _term SIGTERM

$ACTIVEMQ_EXECUTABLE $ACTIVEMQ_ARGS &
PID=$!

wait $PID
