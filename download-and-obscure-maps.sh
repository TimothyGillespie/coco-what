#!/bin/bash

MAPS_FILE="maps.json"

## temp-unzip for temporary unzipping of the maps 
mkdir -p temp-unzip www/maps

jq -c '.[]' $MAPS_FILE | while read i; do
    
    # Extract the map details
    mapperName=$(echo $i | jq -r '.mapperName')
    mapId=$(echo $i | jq -r '.mapId')
    downloadLink=$(echo $i | jq -r '.downloadLink')

    # Check if map already exists
    if [ -f "www/maps/${mapId}.zip" ]; then
        echo "$mapId already exists, skipping download."
        continue
    fi

    # Download the map
    echo "Downloading $mapId.zip..."
    curl -L $downloadLink -o "${mapId}.zip"

    # Unzip to a temporary directory
    mkdir -p "temp-unzip/${mapId}"
    unzip "${mapId}.zip" -d "temp-unzip/${mapId}"

    # Modify Info.dat
    INFO_FILE="temp-unzip/${mapId}/Info.dat"
    if [ -f "$INFO_FILE" ]; then
        jq '._songName = "secret" | ._songAuthorName = "secret" | ._levelAuthorName = "secret" | ._songSubName = "secret" | ._coverImageFilename = "cover.png"' $INFO_FILE > temp.json && mv temp.json $INFO_FILE
    fi

    # Replace the cover image
    cp ./cover.png "temp-unzip/${mapId}/cover.png"

    # Zip the files again
    (cd "temp-unzip/${mapId}" && zip -r "../../www/maps/${mapId}.zip" .)

    # Cleanup
    rm -rf "temp-unzip/${mapId}" "${mapId}.zip"
    echo "$mapId processed."
done

rm -rf temp-unzip

echo "All maps processed."
