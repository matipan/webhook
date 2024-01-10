FROM golang:1.14-alpine AS build
WORKDIR /webhook
COPY go.mod go.mod
COPY go.sum go.sum
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /webhook/webhook

FROM scratch AS runtime
COPY --from=build /webhook/webhook /webhook
ENTRYPOINT ["/webhook"]
