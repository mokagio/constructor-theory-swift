import Testing
@testable import ConstructorTheory

struct `Task Tests` {

  func `dummy test`() {
    _ = Task(
      transformation: Transformation(
        input: Attribute(substrates: [Substrate()]),
        output: Attribute(substrates: [Substrate(), Substrate()]),
      )
    )
    #expect(Bool(true))
  }
}
