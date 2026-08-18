public struct Task {
  let transformation: Transformation
}

public struct Transformation {
  let input: Attribute
  let output: Attribute
}

public struct Attribute {
  let substrates: [Substrate]
}

public struct Substrate {}
