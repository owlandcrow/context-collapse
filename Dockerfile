FROM codesimple/elm:0.19

WORKDIR /code

# start with dependencies to enjoy caching
COPY ./elm.json /code/elm.json
COPY ./src/Test.elm /code/Test.elm
RUN elm make src/Test.elm --output=dist/avocomm.js

# copy rest and build for real
COPY . /code
RUN npm install

# copy rest and build
COPY . /code/.
RUN elm make src/Controller.elm --output=dist/avocomm.js --optimize
RUN uglifyjs dist/avocomm.js --compress 'pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output dist/avocomm.min.js
RUN mv dist/avocomm.min.js dist/avocomm.js
