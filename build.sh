#!/usr/bin/env bash

RELEASE=v0.1.0
RELEASE_DIR=releases
mkdir -p "${RELEASE_DIR}"

build() {
    go build -o "${RELEASE_DIR}/terraform-provider-minikube.${RELEASE}.${GOARCH}.${GOOS}"
}

export GOARCH=amd64

export GOOS=darwin
build
export GOOS=linux
build