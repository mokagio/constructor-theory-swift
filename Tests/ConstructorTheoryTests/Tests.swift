import Testing

@testable import ConstructorTheory

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

var coin: Substrate<CoinState> {
  Substrate(states: [CoinState(facing: .heads), CoinState(facing: .tails)])
}

struct `Task Tests` {

  @Test func `dummy test`() {
    _ = Task(
      transformation: Transformation(
        input: Attribute(substrate: coin, property: Facing.heads),
        output: Attribute(substrate: coin, property: Facing.tails),
      )
    )
    #expect(Bool(true))
  }
}

struct `Substrate Tests` {

  @Test func `a substrate holds the states of one kind`() {
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

struct `Attribute Tests` {

  @Test func `an attribute keeps only the states with the property`() {
    let heads = Attribute(substrate: coin, property: Facing.heads)

    #expect(heads.states == [CoinState(facing: .heads)])
  }

  @Test func `a property no state has makes an empty attribute`() {
    let tailsOnly = Substrate(states: [CoinState(facing: .tails)])

    #expect(Attribute(substrate: tailsOnly, property: Facing.heads).states.isEmpty)
  }
}
