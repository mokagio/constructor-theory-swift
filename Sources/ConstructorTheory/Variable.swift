struct Variable<S: State> {
  let attributes: Set<Attribute<S>>

  init(_ attributes: Set<Attribute<S>>) throws(NotDisjoint<S>) {
    try attributes.requireDisjoint()
    self.attributes = attributes
  }
}

struct NotDisjoint<S: State>: Error, Equatable {
  let attributes: Set<Attribute<S>>
  let sharedStates: Set<S>
}

extension Set {
  func requireDisjoint<S: State>() throws(NotDisjoint<S>) where Element == Attribute<S> {
    var seen: Set<S> = []
    var shared: Set<S> = []
    for attribute in self {
      shared.formUnion(seen.intersection(attribute.states))
      seen.formUnion(attribute.states)
    }
    guard shared.isEmpty else {
      throw NotDisjoint(
        attributes: filter { !$0.states.isDisjoint(with: shared) },
        sharedStates: shared
      )
    }
  }
}
