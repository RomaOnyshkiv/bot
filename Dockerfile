FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app
COPY . .
RUN make goget
RUN make build

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/bot .
COPY --from=builder /go/src/app/.env .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
EXPOSE 8080
ENTRYPOINT [ "./bot", "start" ]

#docker run --env-file ./.env  gbot start