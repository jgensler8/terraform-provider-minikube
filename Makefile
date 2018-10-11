RELEASE_VERSION=v0.4.0
GOARCH?=amd64
BINARY=terraform-provider-minikube_${RELEASE_VERSION}_x4
LINUX_RELEASE=terraform-provider-minikube_${RELEASE_VERSION}_linux_${GOARCH}
MAC_RELEASE=terraform-provider-minikube_${RELEASE_VERSION}_darwin_${GOARCH}

default: deps assets_hack linux mac

deps:
	go get -d -v ./...

assets_hack:
	make -C ${GOPATH}/src/k8s.io/minikube pkg/minikube/assets/assets.go

clean:
	rm ${LINUX_RELEASE} ${MAC_RELEASE} ${LINUX_RELEASE}.zip ${MAC_RELEASE}.zip

linux:
	GOOS=linux GOARCH=${GOARCH} go build -o "${BINARY}"
	zip "${LINUX_RELEASE}.zip" "${BINARY}"
	rm "${BINARY}"

mac:
	GOOS=darwin GOARCH=${GOARCH} go build -o "${BINARY}"
	zip "${MAC_RELEASE}.zip" "${BINARY}"
	rm "${BINARY}"