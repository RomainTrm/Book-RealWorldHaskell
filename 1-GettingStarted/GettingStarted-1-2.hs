-- Exercice 1

5 + 8           -- -> 13, it :: Num a => a
3 * 5 + 8       -- -> 25, it :: Num a => a
2 + 4           -- -> 6, it :: Num a => a
(+) 2 4         -- -> 6, it :: Num a => a
sqrt 16         -- -> 4.0, it :: Floating a => a
succ 6          -- -> 7, it :: (Enum a, Num a) => a
succ 7          -- -> 8, it :: (Enum a, Num a) => a
pred 9          -- -> 8, it :: (Enum a, Num a) => a
pred 8          -- -> 7, it :: (Enum a, Num a) => a
sin (pi / 2)    -- -> 1.0, it :: Floating a => a
truncate pi     -- -> 3, it :: Integral b => b
round 3.5       -- -> 4, it :: Integral b => b
round 3.4       -- -> 3, it :: Integral b => b
floor 3.7       -- -> 3, it :: Integral b => b
ceiling 3.3     -- -> 4, it :: Integral b => b


-- Exercice 2

let x = 1
:show bindings
-- -> it :: Integral b => b = _
-- -> x :: Num p => p = _