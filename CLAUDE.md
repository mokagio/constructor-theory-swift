# ConstructorTheory

A toy Swift package modelling the notions of constructor theory, derived step by step from the papers.
`README.md` is the workbench: each concept is quoted from the source, then unpacked into Swift.
The package is the tidied-up result of that derivation — when the two disagree, the README's reasoning wins and the code follows it.

## Commands

```sh
swift build
swift test
swift format --in-place --parallel --recursive Package.swift Sources Tests
swift format lint --strict --parallel --recursive Package.swift Sources Tests
```

## Conventions

- Swift 6.3 tools, Swift 6 language mode.
- Tests use [Swift Testing](https://developer.apple.com/documentation/testing) (`@Suite`, `@Test`, `#expect`). Do not add XCTest.
- Formatting is `swift-format` with the config in `.swift-format`: two-space indent, 100-column lines. Format before committing.
- One concept per file, named after it (`Task.swift`).
- Doc comments carry the paper's definition of a type; keep them to the definition.
