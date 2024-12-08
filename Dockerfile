FROM node:lts

RUN npm install uglify-js -g
RUN curl -sL https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz -o /tmp/elm.gz &&\
    gunzip /tmp/elm.gz &&\
    mv /tmp/elm /usr/local/bin/elm &&\
    chmod +x /usr/local/bin/elm

WORKDIR /code

# start with dependencies to enjoy caching
COPY ./elm.json /code/elm.json
COPY ./src/Test.elm /code/src/Test.elm
RUN elm make src/Test.elm --output=dist/avocomm.js

# copy rest and build
COPY . /code/.
RUN elm make src/Controller.elm --output=dist/avocomm.js --optimize
RUN uglifyjs dist/avocomm.js --compress 'pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output dist/avocomm.min.js
RUN mv dist/avocomm.min.js dist/avocomm.js
