import Data.List

-- Exercise 3

mean :: [Int] -> Float
mean list = (sum list) / listLength
    where sum [] = 0.0
          sum (x:xs) = (fromIntegral x) + (sum xs)
          listLength = fromIntegral (length list)

-- Exercise 4 

listPalindrome :: [a] -> [a]
listPalindrome []     = []
listPalindrome (x:xs) = x:(listPalindrome xs) ++ [x]

-- Exercise 5

isPalindrome :: Eq a => [a] -> Bool
isPalindrome list = list == (reverse list)

-- Exercise 6

sortByLength :: [[a]] -> [[a]] 
sortByLength lists = sortBy (\a b -> compare (length a) (length b)) lists
-- Alternative solution with sortOn :
-- sortByLength lists = sortOn length lists

-- Exercise 7

myIntersperse :: a -> [[a]] -> [a]
myIntersperse _ []       = []
myIntersperse _ [single] = single
myIntersperse sep (x:xs) = x ++ [sep] ++ (myIntersperse sep xs)