#!/usr/bin/env sh
set -eu

mix deps.get

(cd lib/calm/www ; npm install)

# NOTE there is a race condition between the db service starting
# and the project itself starting. This code will retry until the db can be connected to.
attempts=20
for i in `seq $attempts`; do
    mix ecto.create >/dev/null && break
    echo "Attempt $i / $attempts - failed to create db for the Repo"
    sleep 1
done

if [ $i -eq $attempts ]; then
    echo "Could not connect to the database, exiting"
    exit 2;
fi

mix ecto.migrate

elixir --sname app -S mix run --no-halt

