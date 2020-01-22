
safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_)  = Just x

safeTail :: [a] -> Maybe [a]
safeTail []   = Nothing
safeTail list = Just (tail list)

sageLast :: [a] -> Maybe a
sageLast []   = Nothing
sageLast list = Just (last list)

safeInit :: [a] -> Maybe [a]
safeInit []   = Nothing
safeInit list = Just (init list)