# Coco What: A Beat Saber Map Guessing Game

This is a small, sub 1 hour project to guess Beat Saber mapper/map based on the pattern. You can optionally mute the browser tab to also have no music for hint.

## What does the name mean?

When asking my friends "What should I call this?" Bellus - not having heard the question correctly - asked "Coco What?". That was the best suggestion so we went with that.

## Prerequisites

- jq
- curl
- zip/unzip

## How do use this (Linux Instructions)

1. **Prepare the `maps.json` file**: This file should contain information about the Beat Saber maps you want to use. Each map should have a `mapperName`, `mapperId`, and `downloadLink`. You can create this JSON array manually, or you can use the provided JavaScript code to generate it from a BeatSaver Playlist.

2. **Run the `download-and-obscure-maps.sh` script**: This script downloads the maps from their `downloadLink`s, obscures them to hide any identifying information, and replaces their cover images with a generic `cover.png` image. The obscured maps are saved in the `www/maps` directory. If a map with the same ID has already been downloaded, it will be skipped.

3. **Run the `copy-maps.sh` script**: This script copies the `maps.json` file into the `www` directory, but removes the `downloadLink` key from each map. This is to prevent users from being able to download the original, unobscured maps.

4. **Serve the `www` directory as static files**: The final step is to serve the `www` directory to the web as static files. The index.html is the actual application and will make use of then also hosted obscured maps and the reduced `maps.json`.

## How could this be improved

This has been only a 1 hour project, so it is rather bare bone. It could be enhanced in the following ways:

- Obscure difficulties
- Randomly select the difficulty
- Add configurations
- Utilize user provided BeatSaver playlists or list of IDs (will require a backend for the obscuring etc.)
- Make it pretty
- Have a way to actually guess (apart from just clicking a button to see it)

## Demo

See a demo under https://cocowhat.kparty.io
