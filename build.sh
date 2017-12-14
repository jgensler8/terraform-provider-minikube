#!/usr/bin/env bash

set -e

RELEASE=v0.1.0
RELEASE_DIR=releases
if [ -d "${RELEASE_DIR}" ] ; then
    rm -rf "${RELEASE_DIR}"
fi
mkdir -p "${RELEASE_DIR}"

build() {
    local RELEASE="${RELEASE_DIR}/terraform-provider-minikube.${RELEASE}.${GOARCH}.${GOOS}"
    go build -o "${RELEASE}"
    tar -cvzf "${RELEASE}.tar.gz" "${RELEASE}"
}

export GOARCH=amd64

export GOOS=darwin
build
#export GOOS=linux
#build