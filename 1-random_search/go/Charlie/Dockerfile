FROM golang:alpine

COPY random_search.go /go/src/random_search.go
WORKDIR /go/src
RUN apk add --no-cache git && \
    go get github.com/olekukonko/tablewriter

CMD ["go", "run", "random_search.go"]
