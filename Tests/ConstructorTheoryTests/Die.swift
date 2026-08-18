@testable import ConstructorTheory

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
