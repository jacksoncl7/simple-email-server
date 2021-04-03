FROM alpine

WORKDIR $(pwd)

VOLUME $(pwd)

RUN apk update && apk add ruby

CMD ["ruby", "entrypoint.rb"]
