VERSION=$(shell git describe --tags)-$(shell git rev-parse --short HEAD)

format:
	gofmt -s -w ./

build: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell uname -m} go build -v -o bot -ldflags "-X="github.com/romaonyshkiv/bot/cmd.appVersion=${VERSION}