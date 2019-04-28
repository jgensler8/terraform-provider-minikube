RELEASE_VERSION=v0.5.0
RELEASE_DIR=releases
GOARCH?=amd64
BINARY=terraform-provider-minikube_${RELEASE_VERSION}_x4
LINUX_RELEASE=terraform-provider-minikube_${RELEASE_VERSION}_linux_${GOARCH}
MAC_RELEASE=terraform-provider-minikube_${RELEASE_VERSION}_darwin_${GOARCH}
MINIKUBE_VERSION=v0.30.0

default: deps assets_hack linux mac stage

deps:
	go get -d

assets_hack:
	chmod -R 777 ${GOPATH}/pkg/mod/k8s.io/minikube@${MINIKUBE_VERSION}
	go get -u github.com/jteeuwen/go-bindata/...
	go-bindata -nomemcopy -o ${GOPATH}/pkg/mod/k8s.io/minikube@${MINIKUBE_VERSION}/pkg/minikube/assets/assets.go -pkg assets ${GOPATH}/pkg/mod/k8s.io/minikube@${MINIKUBE_VERSION}/deploy/addons/...

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