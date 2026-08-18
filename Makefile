.DEFAULT_GOAL := test

.PHONY: build test format lint clean

build:
	swift build

test:
	swift test

format:
	swift format --in-place --parallel --recursive Package.swift Sources Tests

lint:
	swift format lint --strict --parallel --recursive Package.swift Sources Tests

clean:
	swift package clean
