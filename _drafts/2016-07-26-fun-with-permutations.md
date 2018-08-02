---
layout: post
title:  "Fun with Permutations"
date:   2016-07-26 20:15:00 +0200
categories: haskell math
---
*If I give you a set of four balls, one green, one red, one blue and one yellow, how many permutations can you make of this set? I will give you the answer right away, it's 24. But now, what if I asked you again how many orderings you can make with this set, but instead of picking four balls for each ordering, you can pick only three ([partial permutation](https://en.wikipedia.org/wiki/Partial_permutation)). The answer is again 24. If this surprises you, then this post is for you.*

# Preliminaries

We'll examine this property of permutations using [Haskell](https://www.haskell.org/). I'm assuming you know the basics of this language, or another functional programming language, to follow along with the examples.

Let's start by setting up a module and defining a data type to represent the balls. Of course we will want our code to work on lists of any type, but we will use the type `Ball` for the sake of the example. Notice we derive the instance types of `Show`, `Eq` and `Ord` on the data type, which will facilitate the process later on.
{% highlight hs %}
module Permutations where

data Ball = Green | Red | Blue | Yellow deriving (Show, Eq, Ord)
{% endhighlight %}

# Approach

Now, with this in place it is time to determine our approach to creating the partial permutations. As an end result, we want a function that takes in a set and an integer and produces a set of all partial permutations of the given length.

We will create a recursive function `orderings`, which adopts the fixed-head solution for calculating permutations. It works in the following way:

## Base case
Given an empty set, the function returns a set with an empty set.

## Recursive case
- Select each element in the set one by one;
- Recursively call the function to generate all orderings of the remaining elements;
- Put the selected element at the head of each of these orderings;
- Join together the orderings that were generated this way for each element in the set.

{% highlight hs %}
orderings :: [a] -> [[a]]
orderings [] = []
orderings (x:xs) = error "No content"


pick :: [a] -> a
pick [] = error "Cannot pick from empty list"
pick (x:xs) = x
{% endhighlight %}

> *Permutations> sumOf 1 :: Integer

> 1

# Conclusion

The reason why `(length possibleDeckSortingsThree) == (length possibleDeckSortingsFour)` is that with four elements to chose from, after the first three have been chosen, there is only one element left to pick, which means a single option. That means the picking of the fourth element creates exactly as many sortings as the picking of only three elements, as it does not broaden the option space. In the factorial formula you can see this, the final multiplication factor is 1, which does not change the outcome anymore.

You can download the full code of this post [here]({{ "/assets/Permutations.hs" | prepend: site.baseurl }}).

Note, to rule out the requirement for the Eq instance type, it should be possible to create a function that given a set, produces a set of 2-tuples where each element in the set is combined with the remainder of that set. Instead of using the map function you could then iterate over this set, thereby illuminating the Eq requirement.
