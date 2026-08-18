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
