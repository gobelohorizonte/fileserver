# Start by building the application.
# Criando build em fileserver com distroless
FROM golang:1.11 as builder

RUN go get -u github.com/didip/tollbooth
RUN go get -u github.com/lib/pq
RUN go get -u golang.org/x/crypto/bcrypt
RUN go get -u github.com/dgrijalva/jwt-go

RUN go get -u github.com/jeffotoni/fileserver/route
RUN go get -u github.com/jeffotoni/fileserver/handler
RUN go get -u github.com/jeffotoni/fileserver/models
RUN go get -u github.com/jeffotoni/fileserver/pkg/auth
RUN go get -u github.com/jeffotoni/fileserver/pkg/authi
RUN go get -u github.com/jeffotoni/fileserver/pkg/cors
RUN go get -u github.com/jeffotoni/fileserver/pkg/cryptf
RUN go get -u github.com/jeffotoni/fileserver/pkg/gcolor
RUN go get -u github.com/jeffotoni/fileserver/pkg/logf
RUN go get -u github.com/jeffotoni/fileserver/pkg/pg
RUN go get -u github.com/jeffotoni/fileserver/repo
RUN go get -u github.com/jeffotoni/fileserver/util

WORKDIR /go/src/fileserver

COPY . .

# RUN go get -d -v ./...
RUN go install -v .

# Now copy it into our base image.
FROM gcr.io/distroless/base

COPY --from=builder /go/bin/fileserver /

CMD ["/fileserver"]
