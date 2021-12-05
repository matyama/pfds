# Terminology

## Evaluation
**call-by-value** is a *strict evaluation* scheme which for a call `f x` evaluates an expression `x` before the call to a function `f`

**call-by-name** is a *lazy evaluation* scheme which for a call `f x` does not immediately evaluate an expression `x` but rather capture its environment and evaluates it when it's needed by the code of function `f`. However, each time `f` is called, so is `x` evaluated.

This scheme can be used to yield *amortized bounds* for *ephemeral* data structures, howeven, for *persistent* ones one could call certain operation multiple times and the amortized bound may collapse to the worst case bound if the operation is expensive.

**call-by-need** is a *lazy evaluation and memoization* scheme which behaves similarly to *call-by-name* with the important difference that once `x` is evaluated, it is also memoized and thus successive calls to `f` do not re-evaluate `x`.

This scheme is required to retain *amortized bounds* for *persistent* data structures for which one assumes arbitrary logical futures of operations (operation sequencing).

## Persistence
 - **Persistent** data structure - *always* preserves the previous version of itself when it is modified (even concurrently)
 - **Ephemeral** data structure - might not preserve its complexity characteristics when accessed and modified concurrently even when implemented as immutable (especially amortized times)

## Rebuilding
**Batched rebuilding** is a balancing technique which restores a *perfect balance* for a data structure after a sequnce of updates rather than after each operation. This approach can yield the same amortized bounds as the base one given
 1. rebuilding is not too frequent
 1. individual updates do not significantly degrade the performance of successive ones

*See formal definition in the book.*

**Global rebuilding** is a technique extending *batched rebuilding* which eliminates amortized bounds by executing the rebuilding transformation incrementally (few steps per operation).

We maintain two copies of the data structure:
 1. all queries and updates operate on a *primary / working copy*
 2. while rebuilding is done on a *secondary copy*.

When the rebuilding is finished these copies are swapped and updates to the previous working copy that have been buffered over time since the last swap are applied to the new one (to make it up to date).

Next rebuilding might start immediately of after a while.

**Lazy rebuilding** is a variant of *global rebuilding* which does not immediately "execute" the rebuilding transformation concurrently with normal operation but rather "pays for" the rebuilding concurrenly. The "execution" is postponed to some later time when it's been "paid for".

Furthermore, with nested suspensions (created by lazy operations) it is often possible to maintain single lazy data structure in which the evaluated and memoized portion (the one that's been "paid for") represents the *working* part and the rest is an analogy to the *secondary copy*.

Similarly to *global rebuilding* this approach is suitable for *persistent* data structures. On the other hand, it typically gives only amortized bounds (similarly to *batched rebuilding*). Fortunately, worst case bounds can usually be recovered by combining this with *scheduling* - i.e. *lazy rebuilding* with *scheduling* is an instance of *global rebuilding*.

## Scheduling
**Scheduling** is a technique in which a data structure maintains a collection of unevaluated suspensions (results of lazy operations) - a *schedule* - for execution at specific (controlled) time.

Some members of the schedule may point to suspensions that have already been evaluated (in a different logical future - operation sequencing) but due to memization this can only result in a speed-up.

This technique is typically used in combination with *lazy rebuilding* to make amortized bounds worst case for persistent data structures.

## Real-time data structure
By a **real-time** data structure one can understand a typically *persistent* data structure with efficient *worst case bounds* on its operations (or at least those of interest).

Typical areas where these data structures are used are:
 - *real-time systems* - if an operation misses a hard deadline and causes a system failure then it doesn't matter how many operations finished ahead of a schedule
 - *parallel systems* - if a processor in a synchronous system executes an expensive operation than all the other processors must wait until it completes
 - *interactive systems* - users often value consistency more than raw speed (single extremely slow operation in a sequence is more noticeable than if all operations the sequence are just slightly slower than normal even though the latter sequence may take longer in total)
