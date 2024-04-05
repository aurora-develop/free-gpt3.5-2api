FROM golang:1.21 AS builder

ENV CGO_ENABLED=0

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o /app/free-gpt3.5-2api .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/free-gpt3.5-2api /app/free-gpt3.5-2api

EXPOSE 8080

CMD [ "./free-gpt3.5-2api" ]
