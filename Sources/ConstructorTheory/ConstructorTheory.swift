public struct Task {
  let transformation: Transformation
}

public struct Transformation {
  let input: Attribute
  let output: Attribute
}

public struct Attribute {}

struct Substrate<S: State> {
  let states: Set<S>
}

protocol State: Hashable {
  func hasProperty(_ property: any Property) -> Bool
}

protocol Property {}
