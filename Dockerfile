FROM node:20

RUN wget --no-check-certificate https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /tmp/jq-linux64
RUN cp /tmp/jq-linux64 /usr/bin/jq
RUN chmod +x /usr/bin/jq

WORKDIR /app
COPY . .
# This command will replace the keys in the config.json file with the names of keys with a dollar sign
RUN jq 'to_entries | map_values({ (.key) : ("$" + .key) }) | reduce .[] as $item ({}; . + $item)' ./src/config.json > ./src/config.tmp.json && mv ./src/config.tmp.json ./src/config.json

RUN npm install && npm run build

FROM nginx:1.17

WORKDIR /usr/share/nginx/html

COPY --from=0 /app/dist .

COPY ./entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
