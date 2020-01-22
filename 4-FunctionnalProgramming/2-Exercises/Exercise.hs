import Data.Char

-- Exercise 1

asInt :: String -> Int
asInt ('-':xs) = negate $ asInt xs
asInt xs = foldl accumulate 0 xs
    where accumulate acc i = acc * 10 + digitToInt i

-- Exercise 2  

type ErrorMessage = String

asIntError :: String -> Either ErrorMessage Int
asIntError ('-':xs) = fmap negate $ asIntError xs
asIntError xs = foldl accumulate (Right 0) xs
    where 
        accumulate (Right acc) i 
            | isDigit i = Right $ acc * 10 + digitToInt i
            | otherwise = Left $ "non digit '" ++ [i] ++ "'"
        accumulate error _ = error

-- Exercise 3

concatFoldR :: [[a]] -> [a]
concatFoldR = foldr (++) []

-- Exercise 4

takeWhileRecurse :: (a -> Bool) -> [a] -> [a]
takeWhileRecurse _ [] = []
takeWhileRecurse predicate (x:xs) 
    | predicate x = x : takeWhileRecurse predicate xs
    | otherwise   = []

takeWhileFoldR :: (a -> Bool) -> [a] -> [a]
takeWhileFoldR predicate = foldr func [] 
    where func i acc 
            | predicate i = i : acc
            | otherwise   = []

-- Exercise 5

myGroupBy :: (a -> a -> Bool) -> [a] -> [[a]]
myGroupBy func = foldl helper []
    where helper acc x
            | null acc                 = [[x]]
            | func (last $ last acc) x = (init acc) ++ [(last acc) ++ [x]]
            | otherwise                = acc ++ [[x]]

-- Exercise 6

myAny :: (a -> Bool) -> [a] -> Bool
myAny predicate = foldr ((||) . predicate) False

myCycle :: [a] -> [a]
myCycle xs = foldr (:) (myCycle xs) xs

myWords :: String -> [String]
myWords = foldr func []
    where func c acc 
            | c == ' '  = [] : acc
            | null acc  = [[c]]
            | otherwise = (c : head acc) : (tail acc)

myUnlines :: [String] -> String
myUnlines = foldr (\a b -> concat [a, "\n", b]) ""