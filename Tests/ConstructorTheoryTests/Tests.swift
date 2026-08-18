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

enum Parity: Property {
  case even
  case odd
}

enum Half: Property {
  case low
  case high
}

enum Pip: Int, State {
  case one = 1
  case two
  case three
  case four
  case five
  case six

  var parity: Parity { rawValue.isMultiple(of: 2) ? .even : .odd }

  var half: Half { rawValue > 3 ? .high : .low }

  func hasProperty(_ property: any Property) -> Bool {
    switch property {
    case let parity as Parity:
      return parity == self.parity
    case let half as Half:
      return half == self.half
    default:
      return false
    }
  }
}

var die: Substrate<Pip> {
  Substrate(states: [.one, .two, .three, .four, .five, .six])
}

struct `Die Tests` {

  @Test func `an attribute gathers every state sharing the property`() {
    #expect(Attribute(substrate: die, property: Parity.even).states == [.two, .four, .six])
  }

  @Test func `even and odd split the die between them`() {
    let even = Attribute(substrate: die, property: Parity.even)
    let odd = Attribute(substrate: die, property: Parity.odd)

    #expect(even.states.union(odd.states) == die.states)
    #expect(even.states.isDisjoint(with: odd.states))
  }

  @Test func `properties of different kinds cut across each other`() {
    let even = Attribute(substrate: die, property: Parity.even)
    let high = Attribute(substrate: die, property: Half.high)

    #expect(even.states.intersection(high.states) == [.four, .six])
  }
}
