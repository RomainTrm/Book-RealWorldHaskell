import Data.List

-- Exercise 8

data Tree a = Node a (Tree a) (Tree a)
            | Empty
              deriving (Show)

height :: Tree a -> Int
height Empty                 = 0
height (Node _ left right) = max (1 + height left) (1 + height right)