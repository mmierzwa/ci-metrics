FROM golang:1.20-alpine as builder

WORKDIR /app
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/*.go

COPY --from=golangci/golangci-lint:latest-alpine /usr/bin/golangci-lint /usr/bin/golangci-lint

FROM scratch

COPY --from=builder /app/main .

CMD ["/main"]
