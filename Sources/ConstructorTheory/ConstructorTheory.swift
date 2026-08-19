struct Task<S: State> {
  let transformation: Transformation<S>
}

struct Transformation<S: State> {
  let input: Attribute<S>
  let output: Attribute<S>
}

struct Attribute<S: State>: Hashable {
  let states: Set<S>

  init(substrate: Substrate<S>, property: any Property) {
    states = substrate.states.filter { $0.hasProperty(property) }
  }
}

struct Substrate<S: State> {
  let states: Set<S>
}

protocol State: Hashable, Sendable {
  func hasProperty(_ property: any Property) -> Bool
}

protocol Property {}
