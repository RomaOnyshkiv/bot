APP := $(shell basename $(shell git remote get-url origin))
REGISTRY=onyshkir
VERSION=$(shell git describe --tags)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=amd64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o bot -ldflags "-X="github.com/romaonyshkiv/bot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg TARGETARCH=${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf bot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} -f