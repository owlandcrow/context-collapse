FROM kovarcodes/elmonarm:latest

WORKDIR /code

# start with dependencies to enjoy caching
COPY ./elm.json /code/elm.json
COPY ./src/Test.elm /code/src/Test.elm
RUN elm make src/Test.elm --output=dist/avocomm.js

# copy rest and build
COPY . /code/.
RUN elm make src/Controller.elm --output=dist/avocomm.js --optimize
