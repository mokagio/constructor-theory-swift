A toy project to dip my toes in [Constructor Theory](https://www.constructortheory.org/), with the help of LLMs and through the medium of code.

The starting point is section 1.4, Basic notions, of [Tests of constructor theory](https://arxiv.org/pdf/2606.07352) by Marletto, Deutsch, Vedral.

> The core concept in constructor theory is the notion of a “task.”

```swift
struct Task {}
```

> A task specifies a transformation in the form of an ordered pair of input and output “attributes”, representing physical features of systems on which a task can be performed, which are called “substrates”.

Okay, let's unpack.

> A task specifies a transformation...

```swift
struct Transformation {}

struct Task {
  let transformation: Transformation
}
```

> ...a transformation in the form of an ordered pair of input and output “attributes”...

```swift
struct Attribute {}

struct Transformation {
  let input: Attribute
  let output: Attribute
}

struct Task {
  let transformation: Transformation
}
```


> ...“attributes”, representing physical features of systems on which a task can be performed, which are called “substrates”.

My first guess would be:

```swift
struct Attribute {
  let substrates: [Substrate]
}

struct Substrate {}
```

But the next sentence clarifies attributes.

> An _attribute_ `x` is a set of states of a substrate that share a common property `x`.

So, to define an attribute we need to define a substrate first.
A substrate is something that can have states, and states have properties that can be compared.

```swift
struct Substrate {
  let states: Set<State>
}

protocol State {
  func hasProperty(_ property: Property) -> Bool
}

protocol Property {}
```

That doesn't compile.
`Set` needs its elements to be `Hashable`, and a box holding "some `State`, we don't know which one" cannot be: to hash a value you need to know its type.
So either the states stop being a set, or the substrate stops hiding what kind of state it holds.
The paper says _set_, so keep the set and let the substrate carry its state type:

```swift
struct Substrate<S: State> {
  let states: Set<S>
}

protocol State: Hashable {
  func hasProperty(_ property: any Property) -> Bool
}

protocol Property {}
```

A substrate is now a substrate _of a kind of state_ — a coin's states are all coin states, and no substrate mixes them with a die's.

With this `Substrate` implementation, we can define `Attribute` as...
