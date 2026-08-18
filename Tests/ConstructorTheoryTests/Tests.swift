import Testing

@testable import ConstructorTheory

struct `Task Tests` {

  func `dummy test`() {
    _ = Task(transformation: Transformation())
    #expect(Bool(true))
  }
}
