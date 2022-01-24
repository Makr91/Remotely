#!/bin/bash

echo "Entered main script."

ServerDir=/var/www/remotely
RemotelyData=/remotely-data

AppSettingsVolume=/remotely-data/appsettings.json
AppSettingsWww=/var/www/remotely/appsettings.json

ls -ltrah /var/www/Remotely_Server_Installer

if [ "$BUILD" = true ]; then
  echo "Building from source"
  cd /var/www && ./Remotely_Server_Installer -b false -u $GITUSER -p $KEY -c true -s $URL -i /var/www/remotely  -w 0 -r $REFERENCE
  
  
fi

 wget -q https://github.com/lucent-sea/Remotely/releases/latest/download/Remotely_Server_Linux-x64.zip && \
  unzip -o Remotely_Server_Linux-x64.zip -d /var/www/remotely && \
  rm Remotely_Server_Linux-x64.zip

sed -i 's/DataSource=Remotely.db/DataSource=\/remotely-data\/Remotely.db/' /var/www/remotely/appsettings.json

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
