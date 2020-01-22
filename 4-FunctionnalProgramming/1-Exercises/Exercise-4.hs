import Data.Text (transpose, unpack, pack)

wordsTransposed :: String -> String
-- Solution found https://github.com/benkio/realWorldHaskell/blob/master/ch04/ch04.exercises.hs
wordsTransposed = unwords . map unpack . transpose . map pack . words