FROM golang:alpine AS build
RUN apk --no-cache add ca-certificates
ADD . /src
WORKDIR /src
RUN go build -o goapp -gcflags="-dwarflocationlists=true"

FROM alpine
WORKDIR /app
COPY --from=build /src/goapp /app/
EXPOSE 5672
ENTRYPOINT ./goapp