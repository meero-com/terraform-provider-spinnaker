FROM golang:1.15 as builder

WORKDIR /sources

COPY . .

RUN go get -d -v ./...
RUN GOOS=linux GOARCH=amd64 go build -o terraform-provider-spinnaker-linux-amd64
RUN GOOS=darwin GOARCH=amd64 go build -o terraform-provider-spinnaker-darwin-amd64

FROM scratch
COPY --from=builder /sources/terraform-provider-spinnaker-* .
