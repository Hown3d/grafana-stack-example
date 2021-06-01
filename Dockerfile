FROM golang:1.16-buster as builder

WORKDIR /app

COPY ./app /app

RUN go mod download

RUN go build -o ./go-prom .


FROM gcr.io/distroless/base-debian10

COPY --from=builder /app/go-prom /app/go-prom

EXPOSE 8080

CMD [ "/app/go-prom" ]