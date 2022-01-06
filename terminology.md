# Terminology

## Evaluation
**call-by-value** is a *strict evaluation* scheme which for a call `f x`
evaluates an expression `x` before the call to a function `f`

**call-by-name** is a *lazy evaluation* scheme which for a call `f x`
does not immediately evaluate an expression `x` but rather capture its
environment and evaluates it when it's needed by the code of function
`f`. However, each time `f` is called, so is `x` evaluated.

This scheme can be used to yield *amortized bounds* for *ephemeral* data
structures, however, for *persistent* ones one could call certain
operation multiple times and the amortized bound may collapse to the
worst-case bound if the operation is expensive.

**call-by-need** is a *lazy evaluation and memoization* scheme which
behaves similarly to *call-by-name* with the important difference that
once `x` is evaluated, it is also memoized and thus successive calls to
`f` do not re-evaluate `x`.

This scheme is required to retain *amortized bounds* for *persistent*
data structures for which one assumes arbitrary logical futures of
operations (operation sequencing).

## Persistence
 - **Persistent** data structure - *always* preserves the previous
		 version of itself when it is modified (even concurrently)
 - **Ephemeral** data structure - might not preserve its complexity
		 characteristics when accessed and modified concurrently even when
		 implemented as immutable (especially amortized times)

## Rebuilding
**Batched rebuilding** is a balancing technique which restores a
*perfect balance* for a data structure after a sequence of updates
rather than after each operation. This approach can yield the same
amortized bounds as the base one given
 1. rebuilding is not too frequent
 1. individual updates do not significantly degrade the performance of
		successive ones

*See formal definition in the book.*

**Global rebuilding** is a technique extending *batched rebuilding*
which eliminates amortized bounds by executing the rebuilding
transformation incrementally (few steps per operation).

We maintain two copies of the data structure:
 1. all queries and updates operate on a *primary / working copy*
 2. while rebuilding is done on a *secondary copy*.

When the rebuilding is finished these copies are swapped and updates to
the previous working copy that have been buffered over time since the
last swap are applied to the new one (to make it up to date).

Next rebuilding might start immediately of after a while.

**Lazy rebuilding** is a variant of *global rebuilding* which does not
immediately "execute" the rebuilding transformation concurrently with
normal operation but rather "pays for" the rebuilding concurrently. The
"execution" is postponed to some later time when it's been "paid for".

Furthermore, with nested suspensions (created by lazy operations) it is
often possible to maintain single lazy data structure in which the
evaluated and memoized portion (the one that's been "paid for")
represents the *working* part and the rest is an analogy to the
*secondary copy*.

Similarly to *global rebuilding* this approach is suitable for
*persistent* data structures. On the other hand, it typically gives only
amortized bounds (similarly to *batched rebuilding*). Fortunately,
worst-case bounds can usually be recovered by combining this with
*scheduling* - i.e. *lazy rebuilding* with *scheduling* is an instance
of *global rebuilding*.

## Scheduling
**Scheduling** is a technique in which a data structure maintains a
collection of unevaluated suspensions (results of lazy operations) - a
*schedule* - for execution at specific (controlled) time.

Some members of the schedule may point to suspensions that have already
been evaluated (in a different logical future - operation sequencing)
but due to memization this can only result in a speed-up.

This technique is typically used in combination with *lazy rebuilding*
to make amortized bounds worst case for persistent data structures.

## Real-time data structure
By a **real-time** data structure one can understand a typically
*persistent* data structure with efficient *worst case bounds* on its
operations (or at least those of interest).

Typical areas where these data structures are used are:
 - *real-time systems* - if an operation misses a hard deadline and
		 causes a system failure then it doesn't matter how many operations
		 finished ahead of a schedule
 - *parallel systems* - if a processor in a synchronous system executes
		 an expensive operation than all the other processors must wait
		 until it completes
 - *interactive systems* - users often value consistency more than raw
		 speed (single extremely slow operation in a sequence is more
		 noticeable than if all operations the sequence are just slightly
		 slower than normal even though the latter sequence may take longer
		 in total)

## Recursive data structure
Data structures where at least one definition (type constructor)
contains a component over the type being defined - i.e. is defined
recursively.

There are two variants of recursive data structures:
 1. **uniformly recursive** - the recursive component is identical to
		the type being defined
 1. **non-uniformly recursive** - the recursive component may be more
		complex than (different from) the type being defined

### Example: Uniform and non-uniform list
```haskell
-- | Uniform list
data List a = Nil | Cons a (List a)

-- | Non-uniform list
data List a = Nil | Cons a (List (a, a))
```

### Polymorphic recursion
Some languages (for instance SML) allow the definition of *non-uniform*
data structures but restrict recursive calls to be uniform over the type
of the enclosing function.

It is always possible to convert a *non-uniform* data structure to a
*uniform* one at the cost of a larger representation and thus additional
pattern matching costs. For instance the *non-uniform* `List` can be
represented as
```haskell
data EP a = Elem a | Pair (EP a) (EP a)
data List a = Nil | Cons (EP a) (List a)
```

Languages with **polymorphic recursion** (Haskell) allow *non-uniform*
recursive definitions and thus do not incur such costs and their
function definitions are more concise.

## Bootstrapping
Generally, **bootstrapping** refers to a problem whose solutions require
solutions to (simpler) instances of the same problem.

In the domain of data structures, *bootstrapping* may take several
forms:
 - **structural decomposition** constructs complete data structures from
		 incomplete ones
 - **structural abstraction** builds efficient data structures from
		 inefficient ones
 - **aggregation** creates data structures with aggregate elements from
		 data structures with atomic elements

## Structural decomposition
**Structural decomposition** is a *bootstrapping* technique which
constructs complete data structures from incomplete ones which have
bounded size.

Structurally decomposed data structures are recursive structures that
are *non-uniform* - i.e. where the recursive component is not the same
as the one being defined.

### Example: Efficient size of a non-uniform list
```haskell
data List a = Nil | Cons a (List (a, a))

size :: List a -> Int
size Nil = 0
Size (List _ ps) = 1 + 2 * size ps
```

## Structural abstraction
**Structural abstraction** is a which builds *bootstrapped* collections
with efficient `join` operation from *primitive* data structures.

Join operation combines two collections together, for example:
 - *merging* two heaps together (`merge`)
 - *appending* two lists together (`++`)

Because *structural abstraction* creates collections that contain other
collections as elements, `join` can simply insert one collection into
the other.

### Example: Template for structurally abstract data structures
```haskell
-- | Primitive collection of elements of type 'a'
data C a = ...

-- | Assuming 'C' defines a value representing an empty collection
empty :: C a
empty = ...

-- | Assuming 'C' supports insertion of primitive elements 'a'
insert :: a -> C a -> C a
insert x c = ...

-- | Bootstrapped collection of elements of type 'a' that abstracts 'C'
data B a = E | B a (C (B a))

-- | Create bootstrapped collection containing single element
unitB :: a -> B a
unitB x = B x empty

-- | Insert an element to 'B' by bootstrapping 'insert' of 'C'
insertB :: a -> B a -> B a
insertB x E = B x empty
insertB x (B y c) = B x (insert (unitB y) c)

-- | Join two 'B' collections by bootstrapping 'insert' of 'C'
joinB :: B a -> B a -> B a
joinB b E = b
joinB E b = b
joinB (B x c) b = B x (insert b c)
```

The challenging aspect of *structural abstraction* is to support
`delete` operation on the bootstrapped collection. If `(B x c) :: B a`
is a bootstrapped collection and `x :: a` is to be discarded, then one
must design a conversion of the primitive collection `c :: C (B a)` into
the bootstrapped one `B a`.

## Bootstrapping to aggregate types
Structural *decomposition* and *abstraction* build collections of
non-aggregate data (e.g. heaps of elements) from collections of
aggregate data (e.g. heaps of heaps).

But bootstrapping simply stops with these *aggregate* types which are
useful on their own. For instance finite maps defined over some simple
type can be bootstrapped to finite maps over lists or even trees of that
type.

## Recursive slowdown
*Recursive slowdown* is a generalization of the idea behind the
*segmented redundant binary numbers* to other data structures.

This numerical representation can be viewed as a template for data
structures composed of a sequence of levels where each level can be
classified as
 - *green*  (0 in the numerical representation)
 - *yellow* (1 in the numerical representation)
 - *red* (2 in the numerical representation)

> An operation may degrade the color of the first level from *green*
to *yellow* or from *yellow* to *red* but never from *green* to *red*.
[...] The invariant is that the last non-yellow level before a red
level is always green. [...] Consecutive *yellow* levels are grouped
into a block to support efficient access to the first non-yellow level.

## Implicit recursive slowdown
*Implicit recursive slowdown* is a representation framework similar to
the *recursive slowdown* but instead of *segmented redundant* binary
numbers it uses *lazy redundant* representations.

Moreover, *implicit recursive slowdown* combines this numerical
representation with *non-uniform recursive types* - i.e. *structural
decomposition* to be able to prove amortized bounds on operations that
are used not only in isolation but intertwined with others.

The choice of allowed digits from the numerical representation depends
on the operation and the data type. For instance *queue* operations are
summarized in following table:

| supported operations |  allowed digits |
|:--------------------:|:---------------:|
|         cons         |    Zero, One    |
|      cons / head     |     One, Two    |
|      head / tail     |     One, Two    |
|  cons / head / tail  | One, Two, Three |

### Practical applications
Data structures based in this idea are used to implement efficient
*dequeues* and to bootstrap other tree-like structures.

[Finger tree](https://en.wikipedia.org/wiki/Finger_tree) is one example
of such data structure that is used to implement Haskell's
[`Data.Sequence`](https://bit.ly/3G3RxEX).
