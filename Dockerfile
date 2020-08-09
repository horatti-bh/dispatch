FROM    golang AS builder
RUN     mkdir -p /app
WORKDIR /app
COPY    src .
RUN     go get github.com/instana/go-sensor ;\
        go get github.com/streadway/amqp
RUN     go build main.go




FROM    centos
COPY    --from=builder /app/main dispatch
RUN     chmod +x dispatch
CMD     /dispatch