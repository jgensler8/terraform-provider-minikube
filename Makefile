RELEASE_VERSION=v0.4.0
RELEASE_DIR=releases
GOARCH?=amd64
BINARY=terraform-provider-minikube_${RELEASE_VERSION}_x4
LINUX_RELEASE=terraform-provider-minikube_${RELEASE_VERSION}_linux_${GOARCH}
MAC_RELEASE=terraform-provider-minikube_${RELEASE_VERSION}_darwin_${GOARCH}

default: deps assets_hack linux mac stage

deps:
	go get -d -v ./...

assets_hack:
	make -C ${GOPATH}/pkg/mod/k8s.io@v0.30.0/minikube pkg/minikube/assets/assets.go

clean:
	rm -rf "${RELEASE_DIR}"
	rm ${LINUX_RELEASE} ${MAC_RELEASE} ${LINUX_RELEASE}.zip ${MAC_RELEASE}.zip

linux:
	GOOS=linux GOARCH=${GOARCH} go build -o "${BINARY}"
	zip "${LINUX_RELEASE}.zip" "${BINARY}"
	rm "${BINARY}"

mac:
	GOOS=darwin GOARCH=${GOARCH} go build -o "${BINARY}"
	zip "${MAC_RELEASE}.zip" "${BINARY}"
	rm "${BINARY}"

stage:
	mkdir "${RELEASE_DIR}"
	mv "${LINUX_RELEASE}.zip" "${RELEASE_DIR}"
	mv "${MAC_RELEASE}.zip" "${RELEASE_DIR}"
