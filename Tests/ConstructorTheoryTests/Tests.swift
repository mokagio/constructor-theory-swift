import Testing

@testable import ConstructorTheory

struct `Task Tests` {

  @Test func `dummy test`() {
    _ = Task(
      transformation: Transformation(
        input: Attribute(),
        output: Attribute(),
      )
    )
    #expect(Bool(true))
  }
}

struct `Substrate Tests` {

  enum Facing: Property {
    case heads
    case tails
  }

  struct CoinState: State {
    let facing: Facing

    func hasProperty(_ property: any Property) -> Bool {
      property as? Facing == facing
    }
  }

  @Test func `a substrate holds the states of one kind`() {
    let coin = Substrate(states: [CoinState(facing: .heads), CoinState(facing: .tails)])

    #expect(coin.states.count == 2)
    #expect(
      coin.states.allSatisfy {
        $0.hasProperty(Facing.heads) || $0.hasProperty(Facing.tails)
      })
  }

  @Test func `the same state twice is one state`() {
    let coin = Substrate(states: [CoinState(facing: .heads), CoinState(facing: .heads)])

    #expect(coin.states.count == 1)
  }
}
