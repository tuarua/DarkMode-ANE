#!/bin/sh

#Get the path to the script and trim to get the directory.
echo "Setting path to current directory to:"
pathtome=$0
pathtome="${pathtome%/*}"
echo $pathtome

PROJECT_NAME=DarkModeANE

AIR_SDK="/Users/eoinlandy/SDKs/AIRSDK_50.1.1"
echo $AIR_SDK

#Setup the directory.
echo "Making directories."

if [ ! -d "$pathtome/platforms" ]; then
mkdir "$pathtome/platforms"
fi
if [ ! -d "$pathtome/platforms/mac" ]; then
mkdir "$pathtome/platforms/mac"
mkdir "$pathtome/platforms/mac/release"
fi
if [ ! -d "$pathtome/platforms/default" ]; then
mkdir "$pathtome/platforms/default"
fi

#Copy SWC into place.
echo "Copying SWC into place."
cp "$pathtome/../bin/$PROJECT_NAME.swc" "$pathtome/"

#Extract contents of SWC.
echo "Extracting files form SWC."
unzip "$pathtome/$PROJECT_NAME.swc" "library.swf" -d "$pathtome"

#Copy library.swf to folders.
echo "Copying library.swf into place."
cp "$pathtome/library.swf" "$pathtome/platforms/mac/release"
cp "$pathtome/library.swf" "$pathtome/platforms/default"

#Copy native libraries into place.
echo "Copying native libraries into place."
cp -R -L "$pathtome/../../native_library/apple/$PROJECT_NAME/Build/Products/Release/$PROJECT_NAME.framework" "$pathtome/platforms/mac/release"
rm -r "$pathtome/platforms/mac/release/$PROJECT_NAME.framework/Versions"

#Run the build command.
echo "Building Release."
"$AIR_SDK"/bin/adt -package \
-target ane "$pathtome/$PROJECT_NAME.ane" "$pathtome/extension.xml" \
-swc "$pathtome/$PROJECT_NAME.swc" \
-platform MacOS-x86-64 -C "$pathtome/platforms/mac/release" "$PROJECT_NAME.framework" "library.swf" \
-platform default -C "$pathtome/platforms/default" "library.swf"

zip "$pathtome/$PROJECT_NAME.ane" -u "air_package.json"

cp "$pathtome/$PROJECT_NAME.ane" "$pathtome/../../example/extensions/$PROJECT_NAME.ane"


rm -r "$pathtome/platforms/mac"
rm -r "$pathtome/platforms/default"
rm "$pathtome/$PROJECT_NAME.swc"
rm "$pathtome/library.swf"

