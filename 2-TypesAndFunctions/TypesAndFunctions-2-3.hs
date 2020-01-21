-- Exercise 2

lastButOne :: [a] -> a
lastButOne (x:_:[]) = x
lastButOne (_:xs) = lastButOne xs


-- Exercise 3

-- lastButOne "abc" -> 'b'
-- lastButOne "ab" -> 'a'
-- lastButOne "a" -> Exception: Non-exhaustive patterns in function lastButOne