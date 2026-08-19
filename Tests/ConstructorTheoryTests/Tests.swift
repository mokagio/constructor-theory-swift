import Testing

@testable import ConstructorTheory

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
    #expect(die.states.count == 6)

    #expect(coin.states.allSatisfy { $0.hasProperty(Facing.heads) || $0.hasProperty(Facing.tails) })
    #expect(die.states.allSatisfy { $0.hasProperty(Parity.even) || $0.hasProperty(Parity.odd) })
  }

  @Test func `the same state twice is one state`() {
    let twoHeads = Substrate(states: [CoinState(facing: .heads), CoinState(facing: .heads)])
    let threeSixes = Substrate(states: [Pip.six, .six, .six])

    #expect(twoHeads.states.count == 1)
    #expect(threeSixes.states.count == 1)
  }
}

struct `Attribute Tests` {

  @Test func `an attribute gathers every state sharing the property`() {
    #expect(
      Attribute(substrate: coin, property: Facing.heads).states == [CoinState(facing: .heads)])
    #expect(Attribute(substrate: die, property: Parity.even).states == [.two, .four, .six])
  }

  @Test func `a property no state has makes an empty attribute`() {
    let tailsOnly = Substrate(states: [CoinState(facing: .tails)])
    let oddOnly = Substrate(states: [Pip.one, .three, .five])

    #expect(Attribute(substrate: tailsOnly, property: Facing.heads).states.isEmpty)
    #expect(Attribute(substrate: oddOnly, property: Parity.even).states.isEmpty)
  }

  @Test func `two properties can split a substrate between them`() {
    let heads = Attribute(substrate: coin, property: Facing.heads)
    let tails = Attribute(substrate: coin, property: Facing.tails)
    let even = Attribute(substrate: die, property: Parity.even)
    let odd = Attribute(substrate: die, property: Parity.odd)

    #expect(heads.states.union(tails.states) == coin.states)
    #expect(heads.states.isDisjoint(with: tails.states))

    #expect(even.states.union(odd.states) == die.states)
    #expect(even.states.isDisjoint(with: odd.states))
  }

  @Test func `properties of different kinds cut across each other`() {
    let even = Attribute(substrate: die, property: Parity.even)
    let high = Attribute(substrate: die, property: Half.high)

    #expect(even.states.intersection(high.states) == [.four, .six])
  }
}

struct `Variable Tests` {

  @Test func `attributes that share no state make a variable`() throws {
    let heads = Attribute(substrate: coin, property: Facing.heads)
    let tails = Attribute(substrate: coin, property: Facing.tails)
    let even = Attribute(substrate: die, property: Parity.even)
    let odd = Attribute(substrate: die, property: Parity.odd)

    #expect(try Variable([heads, tails]).attributes.count == 2)
    #expect(try Variable([even, odd]).attributes.count == 2)
  }

  @Test func `attributes that share a state do not`() throws {
    let even = Attribute(substrate: die, property: Parity.even)
    let high = Attribute(substrate: die, property: Half.high)

    let failure = try #require(
      #expect(throws: Variable<Pip>.Failure.self) {
        try Variable([even, high])
      }
    )

    if case .attributesNotDisjoint(_, let shared) = failure {
      #expect(shared == [.four, .six])
    }
  }

  @Test func `two properties selecting the same states are one attribute`() throws {
    let even = Attribute(substrate: die, property: Parity.even)
    let alsoEven = Attribute(substrate: die, property: Parity.even)

    #expect(try Variable([even, alsoEven]).attributes.count == 1)
  }
}
