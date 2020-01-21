
data Tree a = Tree {
      node      :: a
    , leftLeaf  :: Maybe (Tree a)
    , rigthLead :: Maybe (Tree a)
    } deriving (Show)

    -- ghci> Tree "node" Nothing (Just (Tree "leaf" Nothing Nothing))
    -- Tree {node = "node", leftLeaf = Nothing, rigthLead = Just (Tree {node = "leaf", leftLeaf = Nothing, rigthLead = Nothing})}

    -- ghci> Tree "node" Nothing Nothing
    -- Tree {node = "node", leftLeaf = Nothing, rigthLead = Nothing}