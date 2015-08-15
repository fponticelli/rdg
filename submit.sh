#!/bin/sh
rm rdg.zip
zip -r rdg.zip src doc test doc.hxml extraParams.hxml haxelib.json LICENSE README.md test build.hxml -x "*/\.*"
haxelib submit rdg.zip
