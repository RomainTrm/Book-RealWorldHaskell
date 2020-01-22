
firstWordOfLine :: String -> String
firstWordOfLine text = unwords $ map (head . words) $ lines text