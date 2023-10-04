#!/bin/bash
#backup mysql databases in the current directory

if [ "$EUID" -ne 0 ]; then
    #if running as a normal user then modify this with the mysql credentials
    DB_USER="your_username"
    DB_PASSWORD="your_password"
else
    #if sudo/root then user is just root
    DB_USER="root"
    DB_PASSWORD=""
fi

#timestamp for backup filename
TIMESTAMP=$(date +%d%H%M%S)

#get all databases
DATABASES=$(mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql)")

#loop through each database and create a backup, backs them up in the current working directory
#when running as root it prompts for password for every database, so just press enter when it pops up lol
for DB_NAME in $DATABASES; do
   mysqldump -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$DB_NAME-$TIMESTAMP.sql"
    
    # Check if the backup was successful
    if [ $? -eq 0 ]; then
        echo "Backup completed successfully for $DB_NAME: $DB_NAME-$TIMESTAMP.sql"
    else
        echo "Backup failed for $DB_NAME"
    fi
done

#TO RESTORE ALL YOU NEED TO DO IS DO (as root) IS "mysql [database-name] < [backup].sql"