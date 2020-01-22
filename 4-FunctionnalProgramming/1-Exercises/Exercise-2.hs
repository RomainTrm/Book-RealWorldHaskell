
splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith _ [] = []
splitWith predicate list = 
    let (first, second) = span predicate list
    in  if null first
        then splitWith (not . predicate) second
        else first : splitWith (not . predicate) second