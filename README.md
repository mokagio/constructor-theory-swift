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
struct Substrate<S: State> {
  let states: Set<S>
}

protocol State: Hashable {
  func hasProperty(_ property: any Property) -> Bool
}

protocol Property {}
```

Notice that the `Hashable` requirement on `State` is necessary for the compiler to allow a `Set` of `State`s.

With this `Substrate` implementation, we can return to the attribute definition:

> An _attribute_ `x` is a set of states of a substrate that share a common property `x`.

```swift
struct Attribute<S: State> {
  let states: Set<S>

  init(substrate: Substrate<S>, property: any Property) {
    states = substrate.states.filter { $0.hasProperty(property) }
  }
}
```

Making `Attribute` generic forces the same parameter onto `Transformation` and `Task`, which now read:

```swift
struct Task<S: State> {
  let transformation: Transformation<S>
}

struct Transformation<S: State> {
  let input: Attribute<S>
  let output: Attribute<S>
}
```

That every component is defined in terms of the same generic `S` makes a structural claim: input and output are attributes of the same kind of state.
This seems to make sense with the paper so far.
