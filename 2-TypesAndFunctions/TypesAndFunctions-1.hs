-- Exercice 1

False                           -- False :: Bool
(["foo", "bar"], 'a')           -- (["foo", "bar"], 'a') :: ([[Char]], Char)
[(True, []), (False, [['a']])]  -- [(True, []), (False, [['a']])] :: [(Bool, [[Char]])]


-- Exercice 1 bis

-- Haskell provides a standard function, last :: [a] -> a, that returns the last element of a list. 
-- From reading the type alone, what are the possible valid behaviours (omitting crashes and infinite loops) that this function could have? 
-- Returns the last element of a list, return the head of a single element list
-- What are a few things that this function clearly cannot do?
-- Transform the value of the list