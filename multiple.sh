#! /bin/bash
rm -rf .parcel-cache
for (( i=1; i<3; i++))
do
	rm -rf dist
	npx parcel build --no-cache --no-content-hash src/index.html &
	npx parcel build --no-cache --no-content-hash src/index.html &
	npx parcel build --no-cache --no-content-hash src/index.html &
	npx parcel build --no-cache --no-content-hash src/index.html || exit 1
done