#!/bin/bash

echo "Entered main script."

expect -c "set timeout -1; spawn /bin/bash /Remotely_Server_Installer -b false -u $GITUSER -p $KEY -c true -s $URL -i /var/www/remotely  -w 0 -r $REFERENCE; sleep 5; expect -re \"enter:\"; send \"\r\n\"; set timeout -1;"

sed -i 's/DataSource=Remotely.db/DataSource=\/remotely-data\/Remotely.db/' /var/www/remotely/appsettings.json

ServerDir=/var/www/remotely
RemotelyData=/remotely-data

AppSettingsVolume=/remotely-data/appsettings.json
AppSettingsWww=/var/www/remotely/appsettings.json

if [ ! -f "$AppSettingsVolume" ]; then
	echo "Copying appsettings.json to volume."
	cp "$AppSettingsWww" "$AppSettingsVolume"
fi

if [ -f "$AppSettingsWww" ]; then
	rm "$AppSettingsWww"
fi

ln -s "$AppSettingsVolume" "$AppSettingsWww"


echo "Starting Remotely server."
exec /usr/bin/dotnet /var/www/remotely/Remotely_Server.dll
