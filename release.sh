haxe doc.hxml
rm -r release
rm release.zip
mkdir release
cp -R src/* release
cp haxelib.xml release
cp doc/doc.neko.xml release/haxedoc.xml
cd release
zip -i ".*" -r ../release.zip .
cd ..
rm -r release
#haxelib submit release.zip