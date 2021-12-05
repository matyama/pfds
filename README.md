# Purely Functional Data Structures
This repository contains selected examples and solutions to exercises
from [*Purely Functional Data Structures*](https://www.goodreads.com/book/show/594288.Purely_Functional_Data_Structures).

## Data Structures

### Queues
|       instance      | persistence | amortization | empty | isEmpty |     snoc     | head |     tail     |
|:-------------------:|:-----------:|:------------:|:-----:|:-------:|:------------:|:----:|:------------:|
|    Batched Queue    |  ephemeral  |      yes     |  O(1) |   O(1)  | O(n) / O(1)* | O(1) | O(n) / O(1)* |
|    Banker's Queue   |  persistent |      yes     |  O(1) |   O(1)  | O(n) / O(1)* | O(1) | O(n) / O(1)* |
|  Physicist's Queue  |  persistent |      yes     |  O(1) |   O(1)  | O(n) / O(1)* | O(1) | O(n) / O(1)* |
|   Real-Time Queue   |  persistent |      no      |  O(1) |   O(1)  |     O(1)     | O(1) |     O(1)     |
| Hood-Melville Queue |  persistent |      no      |  O(1) |   O(1)  |     O(1)     | O(1) |     O(1)     |

*\* amortized time*

### Deques
|                instance               | persistence | amortization | empty | isEmpty |     cons     | head |     tail     |     snoc     | last |     init     |
|:-------------------------------------:|:-----------:|:------------:|:-----:|:-------:|:------------:|:----:|:------------:|:------------:|:----:|:------------:|
|    Output-Restricted Banker's Deque   |  persistent |      yes     |  O(1) |   O(1)  | O(n) / O(1)* | O(1) | O(n) / O(1)* | O(n) / O(1)* |   -  |       -      |
|   Output-Restricted Real-Time Deque   |  persistent |      no      |  O(1) |   O(1)  |     O(1)     | O(1) |     O(1)     |     O(1)     |   -  |       -      |
| Output-Restricted Hood-Melville Deque |  persistent |      no      |  O(1) |   O(1)  |    O(1)**    | O(1) |     O(1)     |     O(1)     |   -  |       -      |
|             Banker's Deque            |  persistent |      yes     |  O(1) |   O(1)  | O(n) / O(1)* | O(1) | O(n) / O(1)* | O(n) / O(1)* | O(1) | O(n) / O(1)* |
|            Real-Time Deque            |  persistent |      no      |  O(1) |   O(1)  |     O(1)     | O(1) |     O(1)     |     O(1)     | O(1) |     O(1)     |

*\* amortized time*
*\*\* via the `ConsQueue` wrapper*

### Random Access List
|                  instance                  | amortization | empty | isEmpty |        cons       |        head        |        tail       |   lookup  |   update  |
|:------------------------------------------:|:------------:|:-----:|:-------:|:-----------------:|:------------------:|:-----------------:|:---------:|:---------:|
|          Binary Random Access List         |      no      |  O(1) |   O(1)  |     O(log(n))     | O(log(n)) / O(1)** |     O(log(n))     | O(log(n)) | O(log(n)) |
|     Zeroless Binary Random Access List     |      no      |  O(1) |   O(1)  |     O(log(n))     |        O(1)        |     O(log(n))     | O(log(i)) | O(log(i)) |
| Zeroless Redundant Bin. Random Access List |      yes     |  O(1) |   O(1)  | O(log(n)) / O(1)* |        O(1)        | O(log(n)) / O(1)* | O(log(i)) | O(log(i)) |

where n is the list size and i is the index parameter of the `lookup`/`update`.

*\* amortized time*

*\*\* with explicit reference to the head element*

### Heaps
|         instance        | persistence | amortization | empty | isEmpty |       insert      |       merge       |           findMin          |     deleteMin     |
|:-----------------------:|:-----------:|:------------:|:-----:|:-------:|:-----------------:|:-----------------:|:--------------------------:|:-----------------:|
|       Leftist Heap      |  ephemeral  |      no      |  O(1) |   O(1)  |     O(log(n))     |     O(log(n))     |            O(1)            |     O(log(n))     |
|      Binomial Heap      |  persistent |      yes     |  O(1) |   O(1)  | O(log(n)) / O(1)* |     O(log(n))     |     O(log(n)) / O(1)**     |     O(log(n))     |
| Scheduled Binomial Heap |  persistent |      no      |  O(1) |   O(1)  |        O(1)       |     O(log(n))     |     O(log(n)) / O(1)**     |     O(log(n))     |
|        Splay Heap       |  ephemeral  |      yes     |  O(1) |   O(1)  | O(n) / O(log(n))* | O(n) / O(log(n))* | O(n) / O(log(n))* / O(1)** | O(n) / O(log(n))* |
|       Pairing Heap      |  ephemeral  |      yes     |  O(1) |   O(1)  |        O(1)       |        O(1)       |            O(1)            | O(n) / O(log(n))* |
|    Lazy Pairing Heap    |  persistent |      yes     |  O(1) |   O(1)  |        TODO       |        TODO       |            O(1)            |        TODO       |

*\* amortized time*

*\*\* with explicit reference to the minimum element*

### Sortable Collections
|       instance       | persistence | amortization | empty |     add    |  sort |
|:--------------------:|:-----------:|:------------:|:-----:|:----------:|:-----:|
|      Merge Sort      |  persistent |      yes     |  O(1) | O(log(n))* | O(n)* |
| Scheduled Merge Sort |  persistent |      no      |  O(1) |  O(log(n)) |  O(n) |

### Sets
|      instance      | persistence | empty |   member  |   insert  |
|:------------------:|:-----------:|:-----:|:---------:|:---------:|
| Binary Search Tree |  ephemeral  |  O(1) |    O(n)   |    O(n)   |
|   Red-Black Tree   |  ephemeral  |  O(1) | O(log(n)) | O(log(n)) |

## Terminology
See [terminology](terminology.md) for brief description and
definition of concepts and techniques from the book that is used to
describe data structure instances in the IHaskell notebooks.

## Notebooks
Haskell code can be found in [IHaskell](https://github.com/gibiansky/IHaskell)
notebooks under the `notebooks` directory. In order to view and edit them
one can start a Docker container running Jupyter with IHaskell kernel via
```bash
make ihaskell
```
or just `make`.

## Disclaimer
Note that this is a personal learning place that was created while
reading the book. I do encourage others to buy and read it!
