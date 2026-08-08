#!/bin/sh

set -eu

# READ THIS! All you have to do is download the APK to be deployed in ./AppDir/apk
# EXAMPLE:
#
#    wget www.link/to/apk/to/download.com -O ./AppDir/apk/appname.apk
#

# appname.apk will end up being the name of the "binary" in the Exec= key of the
# .desktop file (without the .apk), so make sure to give it a proper name as if
# the android application was a native binary in linux
# EXAMPLE:
#    Super-Calculator-v6.7.0.apk -> super-calculator.apk

# YOU ALSO NEED TO DO THE FOLLOWING TO BE ABLE TO RUN THE CI
# make a .desktop file in the AppDir directory for the application in question
# generate a ~/version file that contains the version of the .apk that was downloaded










# # # # # # # # # # # # # # # #
# DO NOT EDIT BELOW THIS LINE #
# # # # # # # # # # # # # # # #
APK=$(set -- ./apk/*.apk; echo "$1")
if [ ! -f "$APK" ]; then
	>&2 echo "ERROR: No .apk file found in './AppDir/apk'!"
	exit 1
elif [ ! -f ~/version ]; then
	>&2 echo "ERROR: No ~/version file found! Create one with the version of the .apk to deploy."
	exit 1
elif [ ! -f ./AppDir/*.desktop ]; then
	>&2 echo "ERROR: No .desktop file in AppDir!"
	exit 1
fi

# Make a dummy shell script to trick quick-sharun into deploying the AppDir
APK=./AppDir/bin/"$(basename "$APK" .apk)"
printf "#!/bin/sh\n:\n" > "$APK"
chmod +x "$APK"
sed -i -e "s|^Exec=.*|Exec=${APK##*/}|" -e "s|^TryExec=.*|TryExec=${APK##*/}|" ./AppDir/*.desktop
