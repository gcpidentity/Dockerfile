#!/bin/bash

ls -l /app/db/

find /app/db/ -iname "*.sqlite3" | while read SQLITE_DATABSE; do
    echo "Running VACUUM on $SQLITE_DATABSE"
    sqlite3 "$SQLITE_DATABSE" "VACUUM;"
done

sleep 5

echo "(Re-)Starting Samson"
cd /app/
bin/rake db:migrate
exec bundle exec puma -C ./config/puma.rb -e "$RAILS_ENV"
