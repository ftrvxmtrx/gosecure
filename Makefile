GOOS=linux
GOFILES=gosecure.go
VERSION=0.1.1-1
VERSION_NAME=Ugly Logger
BINARY_NAME=gosecure

LDFLAGS=-ldflags '-X main.VERSION=$(VERSION) -X "main.VERSION_NAME=$(VERSION_NAME)"'

ifeq ($(GOOS), windows)
	EXE=.exe
endif

all: build

build:
	@GOOS=$(GOOS) go build -o $(BINARY_NAME)$(EXE) $(LDFLAGS) $(GOFILES)

run:
	@GOOS=$(GOOS) go run $(LDFLAGS) $(GOFILES)

.PHONY clean:
	@rm -f $(BINARY_NAME) $(BINARY_NAME).exe

deb: build
	cp man/gosecure.1 deb/$(BINARY_NAME)_$(VERSION)_amd64/usr/share/man/man1 && \
	cp $(BINARY_NAME) deb/$(BINARY_NAME)_$(VERSION)_amd64/opt/gosecure/bin && \
	cd deb && \
	dpkg-deb --build $(BINARY_NAME)_$(VERSION)_amd64 ; \
	cd -
