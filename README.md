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
// Not sure what ordered means
struct Transformation<Input, Output> {
  let input: Input
  let output: Output
}

struct Task {
  let transformation: Transformation
}
```


> ...“attributes”, representing physical features of systems on which a task can be performed, which are called “substrates”.
