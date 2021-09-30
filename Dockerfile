FROM golang:alpine AS build
RUN apk --no-cache add ca-certificates
ADD . /src
WORKDIR /src
RUN go build -o goapp -gcflags="-dwarflocationlists=true"

FROM alpine
RUN apk add --no-cache tzdata
#ENV TZ=America/Sao_Paulo
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
WORKDIR /app
COPY --from=build /src/goapp /app/
EXPOSE 3333
ENTRYPOINT ./goapp