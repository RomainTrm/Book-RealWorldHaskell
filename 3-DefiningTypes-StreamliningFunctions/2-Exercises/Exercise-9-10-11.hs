import Data.List

-- Exercise 9

data Direction =
          Straight
        | TurnLeft
        | TurnRight
        deriving (Show)

-- Exercise 10

type X = Float
type Y = Float
type Point = (X, Y)

findDirection :: Point -> Point -> Point -> Direction
findDirection a b c
    | crossProduct a b c > 0 = TurnLeft
    | crossProduct a b c < 0 = TurnRight
    | crossProduct a b c == 0 = Straight
    where crossProduct (x1,y1) (x2,y2) (x3,y3) = ((x2-x1)*(y3-y1)) - ((x3-y1)*(y2-y1))

-- Exercise 11

getConsecutiveDirections :: [Point] -> [Direction]
getConsecutiveDirections (a:b:c:xs) = findDirection a b c:getConsecutiveDirections (b:c:xs)
getConsecutiveDirections _ = []