#!/bin/bash
set -e
#source /etc/apache2/envvars

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/httpd/httpd.pid
exec httpd -DFOREGROUND &
exec su postgres -c "/usr/pgsql-9.3/bin/postgres -D /pgdata"

# Update default postgres user password
#exec su postgres -c "psql -c \"alter user postgres password 'postgres'\";"
# Start postgres daemon
#exec su postgres -c "/usr/pgsql-9.3/bin/postgres -D /var/lib/pgsql/data"

