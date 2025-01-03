# Context Collapse

You can interact with the demo script at https://context.hyperkind.org

## Running the engine

The easiest way to get started is to download the latest release and
use the included script to start a webserver.

    curl -L https://github.com/owlandcrow/context-collapse/releases/download/v0.0.4/context-collapse-prebuilt.tgz > context-collapse-prebuilt.tgz
    tar xzvf context-collapse-prebuilt.tgz
    cd context-collapse
    python3 server.py

Then go to http://localhost:8020/ in your browser.

You can edit your game by modifying the file `script.camp`
in the `context-collapse` directory; the game will automatically
refresh when you change the script.

## Build

You'll need to have a stable internet connection in order for the elm build
script to download all its dependencies and compile successfully.

    git clone git@github.com:owlandcrow/context-collapse
    cd context-collapse
    elm make src/Controller.elm --output=dist/avocomm.js --optimize

For an debug build, replace `--optimize` in the last command with `--debug`.
To compress the result according to the recommendations
[here](https://guide.elm-lang.org/optimization/asset_size.html), run the following:

    npx uglify-js dist/avocomm.js --compress 'pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe' | npx uglify-js --mangle --output dist/avocomm.min.js
    mv dist/avocomm.min.js dist/avocomm.js

## Creating a release

First, modify README.md to target the next release.

Second, run the build process above.

Third, use the following commands to create the prebuilt release:

    rm -f context-collapse-prebuilt.tgz
    cd ..
    tar czvf context-collapse/context-collapse-prebuilt.tgz -T context-collapse/manifest.txt

## Developing

For development, run the Python script for the server, and use Chokidar
(`npm install --global chokidar-cli`) to watch and recompile the code.

    chokidar '**/*.elm' -c 'elm make src/Controller.elm --output=dist/avocomm.js --debug'
