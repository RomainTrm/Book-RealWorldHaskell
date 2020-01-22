
firstWordOfLine :: String -> String
firstWordOfLine text = unwords $ fmap (head . words) $ lines text