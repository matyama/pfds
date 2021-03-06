# Purely Functional Data Structures
This repository contains selected examples and solutions to exercises
from [*Purely Functional Data Structures*](https://www.goodreads.com/book/show/594288.Purely_Functional_Data_Structures).

## Data Structures

### Queues
[![nbviewer](https://raw.githubusercontent.com/jupyter/design/master/logos/Badges/nbviewer_badge.svg)](https://nbviewer.org/github/matyama/pfds/blob/main/notebooks/queues.ipynb)

|       instance      | persistence |        snoc       | head |        tail       |
|:-------------------:|:-----------:|:-----------------:|:----:|:-----------------:|
|    Batched Queue    |  ephemeral  |    O(n) / O(1)*   | O(1) |    O(n) / O(1)*   |
|    Banker's Queue   |  persistent |    O(n) / O(1)*   | O(1) |    O(n) / O(1)*   |
|  Physicist's Queue  |  persistent |    O(n) / O(1)*   | O(1) |    O(n) / O(1)*   |
|   Real-Time Queue   |  persistent |        O(1)       | O(1) |        O(1)       |
| Hood-Melville Queue |  persistent |        O(1)       | O(1) |        O(1)       |
|  Bootstrapped Queue |  persistent |   O(log\*(n))**   | O(1) |   O(log\*(n))**   |
|    Implicit Queue   |  persistent | O(log(n)) / O(1)* | O(1) | O(log(n)) / O(1)* |

*\* amortized time*

*\*\* amortized time, log\*(n) is constant in practice*

### Deques
[![nbviewer](https://raw.githubusercontent.com/jupyter/design/master/logos/Badges/nbviewer_badge.svg)](https://nbviewer.org/github/matyama/pfds/blob/main/notebooks/deques.ipynb)

#### Output-Restricted Queues
|                instance               | persistence |     cons     | head |     tail     |     snoc     |
|:-------------------------------------:|:-----------:|:------------:|:----:|:------------:|:------------:|
|    Output-Restricted Banker's Deque   |  persistent | O(n) / O(1)* | O(1) | O(n) / O(1)* | O(n) / O(1)* |
|   Output-Restricted Real-Time Deque   |  persistent |     O(1)     | O(1) |     O(1)     |     O(1)     |
| Output-Restricted Hood-Melville Deque |  persistent |    O(1)**    | O(1) |     O(1)     |     O(1)     |

#### Double-Ended Queues
|     instance    | persistence |     cons     | head |     tail     |     snoc     | last |     init     |
|:---------------:|:-----------:|:------------:|:----:|:------------:|:------------:|:----:|:------------:|
|  Banker's Deque |  persistent | O(n) / O(1)* | O(1) | O(n) / O(1)* | O(n) / O(1)* | O(1) | O(n) / O(1)* |
| Real-Time Deque |  persistent |     O(1)     | O(1) |     O(1)     |     O(1)     | O(1) |     O(1)     |

*\* amortized time*

*\*\* via the `ConsQueue` wrapper*

### Catenable Lists
[![nbviewer](https://raw.githubusercontent.com/jupyter/design/master/logos/Badges/nbviewer_badge.svg)](https://nbviewer.org/github/matyama/pfds/blob/main/notebooks/clists.ipynb)

|    instance    | persistence |  cons  |  snoc  |   ++  | head |     tail     |
|:--------------:|:-----------:|:------:|:------:|:-----:|:----:|:------------:|
| Catenable List |  persistent | O(1)** | O(1)** | O(1)* | O(1) | O(n) / O(1)* |

*\* amortized time*

*\*\* depends on the complexity of `snoc` of the underlying queue*

### Catenable Deques
[![nbviewer](https://raw.githubusercontent.com/jupyter/design/master/logos/Badges/nbviewer_badge.svg)](https://nbviewer.org/github/matyama/pfds/blob/main/notebooks/cdeques.ipynb)

|         instance         | persistence |  cons  |  snoc  |     ++     | head |  tail | last |  init |
|:------------------------:|:-----------:|:------:|:------:|:----------:|:----:|:-----:|:----:|:-----:|
|  Simple Catenable Deque  |  persistent | O(1)** | O(1)** | O(log(n))* | O(1) | O(1)* | O(1) | O(1)* |
| Implicit Catenable Deque |  persistent | O(1)** | O(1)** |    O(1)*   | O(1) | O(1)* | O(1) | O(1)* |

*\* amortized time*

*\*\* amortized or worst-case time (depends on the underlying deque instance)*

### Random Access List
[![nbviewer](https://raw.githubusercontent.com/jupyter/design/master/logos/Badges/nbviewer_badge.svg)](https://nbviewer.org/github/matyama/pfds/blob/main/notebooks/rlists.ipynb)

|                  instance                  |        cons       |        head        |        tail       |       lookup      |       update      |
|:------------------------------------------:|:-----------------:|:------------------:|:-----------------:|:-----------------:|:-----------------:|
|          Binary Random Access List         |     O(log(n))     | O(log(n)) / O(1)** |     O(log(n))     |     O(log(n))     |     O(log(n))     |
|    Alternative Binary Random Access List   |     O(log(n))     | O(log(n)) / O(1)** |     O(log(n))     |     O(log(n))     |     O(log(n))     |
|     Zeroless Binary Random Access List     |     O(log(n))     |        O(1)        |     O(log(n))     |     O(log(i))     |     O(log(i))     |
| Zeroless Redundant Bin. Random Access List | O(log(n)) / O(1)* |        O(1)        | O(log(n)) / O(1)* |     O(log(i))     |     O(log(i))     |
|       Skew Binary Random Access List       |        O(1)       |        O(1)        |        O(1)       | O(min(i, log(n))) | O(min(i, log(n))) |

where n is the list size and i is the index parameter of the `lookup`/`update`.

*\* amortized time*

*\*\* with explicit reference to the head element*

### Heaps
[![nbviewer](https://raw.githubusercontent.com/jupyter/design/master/logos/Badges/nbviewer_badge.svg)](https://nbviewer.org/github/matyama/pfds/blob/main/notebooks/heaps.ipynb)

|         instance        | persistence |       insert      |       merge       |           findMin          |     deleteMin     |
|:-----------------------:|:-----------:|:-----------------:|:-----------------:|:--------------------------:|:-----------------:|
|       Leftist Heap      |  ephemeral  |     O(log(n))     |     O(log(n))     |            O(1)            |     O(log(n))     |
|      Binomial Heap      |  persistent | O(log(n)) / O(1)* |     O(log(n))     |     O(log(n)) / O(1)**     |     O(log(n))     |
| Scheduled Binomial Heap |  persistent |        O(1)       |     O(log(n))     |     O(log(n)) / O(1)**     |     O(log(n))     |
|    Skew Binomial Heap   |  persistent |        O(1)       |     O(log(n))     |     O(log(n)) / O(1)**     |     O(log(n))     |
|        Splay Heap       |  ephemeral  | O(n) / O(log(n))* | O(n) / O(log(n))* | O(n) / O(log(n))* / O(1)** | O(n) / O(log(n))* |
|       Pairing Heap      |  ephemeral  |        O(1)       |        O(1)       |            O(1)            | O(n) / O(log(n))* |
|    Lazy Pairing Heap    |  persistent |        O(1)       |       O(1)*       |            O(1)            |     O(log(n))*    |
|    Bootstrapped Heap    |  persistent |       O(1)'       |       O(1)'       |            O(1)            |     O(log(n))'    |

*\* amortized time*

*\*\* with explicit reference to the minimum element*

*' either worst-case or amortized depending on the underlying heap*

### Sortable Collections
[![nbviewer](https://raw.githubusercontent.com/jupyter/design/master/logos/Badges/nbviewer_badge.svg)](https://nbviewer.org/github/matyama/pfds/blob/main/notebooks/sortable.ipynb)

|       instance       | persistence |     add    |  sort |
|:--------------------:|:-----------:|:----------:|:-----:|
|      Merge Sort      |  persistent | O(log(n))* | O(n)* |
| Scheduled Merge Sort |  persistent |  O(log(n)) |  O(n) |

*\* amortized time*

### Sets
[![nbviewer](https://raw.githubusercontent.com/jupyter/design/master/logos/Badges/nbviewer_badge.svg)](https://nbviewer.org/github/matyama/pfds/blob/main/notebooks/sets.ipynb)

|      instance      | persistence |   member  |   insert  |
|:------------------:|:-----------:|:---------:|:---------:|
| Binary Search Tree |  ephemeral  |    O(n)   |    O(n)   |
|   Red-Black Tree   |  ephemeral  | O(log(n)) | O(log(n)) |

### Finite Maps
[![nbviewer](https://raw.githubusercontent.com/jupyter/design/master/logos/Badges/nbviewer_badge.svg)](https://nbviewer.org/github/matyama/pfds/blob/main/notebooks/maps.ipynb)

|    instance   | lookup |  bind |
|:-------------:|:------:|:-----:|
|      Trie     |  O(qm) | O(qm) |
| Trie of Trees |  O(qm) | O(qm) |

where
 - O(q) is the query complexity (e.g. size of an aggregated key `[k]` or `Tree k`)
 - O(m) is the operation complexity of the underlying map `m k`

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
