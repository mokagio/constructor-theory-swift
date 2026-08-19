struct Variable<S: State> {
  enum Failure: Error, Equatable {
    case attributesNotDisjoint(Attribute<S>, sharing: Set<S>)
  }

  let attributes: Set<Attribute<S>>

  init(_ attributes: Set<Attribute<S>>) throws(Failure) {
    var union: Set<S> = []
    for attribute in attributes {
      let shared = union.intersection(attribute.states)
      guard shared.isEmpty else {
        throw .attributesNotDisjoint(attribute, sharing: shared)
      }
      union.formUnion(attribute.states)
    }
    self.attributes = attributes
  }
}
