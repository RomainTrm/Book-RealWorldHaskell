## 1. Load the Control.Arrow module into ghci, and find out what the second function does.

second :: Arrow a => a b c -> a (d, b) (d, c)

For an Arrow a encapsulating a function b -> c, apply the function to the second argument of a two arguments tuple.
The function arr :: (b -> c) -> a b c lift a function to an arrow

Example:

ghci> myArrow = arr $ ((++) "Hello, ")

ghci> :type myArrow
myArrow :: Arrow a => a [Char] [Char]

ghci> second myArrow (True, "Romain") -- The first element of the tuple doesn't matter here, it could be anything
(True, "Hello, Romain")

## 2. What is the type of (,)? When you use it in ghci, what does it do? What about (,,)?

Type of (,) is a -> b (a, b)
It takes two arguments and return a tuple of thoses.
Type of (,,) is a -> b -> c (a, b, c)
This is the same as (,), but for a three arguments tuple.