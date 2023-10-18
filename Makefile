# Preparing folder to hold binary tools
ROOT_FOLDER:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BIN_FOLDER=$(ROOT_FOLDER)/bin

define local_go_install
	GOBIN=$(BIN_FOLDER) go install $(1)
endef

# Tool binaries

## golangci-lint
GOLANGLINT_CI=$(BIN_FOLDER)/golangci-lint
GOLANGLINT_CI_VERSION=v1.54.2

## minio
MINIO=$(BIN_FOLDER)/minio
MINIO_VERSION=RELEASE.2023-10-16T04-13-43Z

.PHONY: all
all: golanglint-ci minio lint

.PHONY: lint
lint: golanglint-ci
	$(GOLANGLINT_CI) run ./...

.PHONY: golanglint-ci
golanglint-ci:
	$(call local_go_install,github.com/golangci/golangci-lint/cmd/golangci-lint@$(GOLANGLINT_CI_VERSION))

.PHONY: minio
minio:
	$(call local_go_install,github.com/minio/minio@$(MINIO_VERSION))
