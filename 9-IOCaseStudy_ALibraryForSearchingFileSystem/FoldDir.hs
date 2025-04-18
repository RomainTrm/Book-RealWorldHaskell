import ControlledVisit
import System.FilePath ((</>))
import BetterPredicate 
import Data.Char
import System.FilePath.Windows

data Iterate seed = Done     { unwrap :: seed }
                  | Skip     { unwrap :: seed }
                  | Continue { unwrap :: seed }
                    deriving (Show)

type Iterator seed = seed -> Info -> Iterate seed

foldTree :: Iterator a -> a -> FilePath -> IO a
foldTree iter initSeed path = do
    endSeed <- fold initSeed path
    return (unwrap endSeed)
  where
    fold seed subpath = getUsefulContents subpath >>= walk seed

    walk seed (name:names) = do
      let path' = path </> name
      info <- getInfo path'
      case iter seed info of
        done@(Done _) -> return done
        Skip seed'    -> walk seed' names
        Continue seed'
          | isDirectory info -> do
              next <- fold seed' path'
              case next of
                done@(Done _) -> return done
                seed''        -> walk (unwrap seed'') names
          | otherwise -> walk seed' names
    walk seed _ = return (Continue seed)

atMostThreePictures :: Iterator [FilePath]
atMostThreePictures paths info
    | length paths == 3                               = Done paths
    | isDirectory info && takeFileName path == ".svn" = Skip paths
    | extension `elem` [".jpg", ".png"]               = Continue (path : paths)
    | otherwise                                       = Continue paths
    where 
        extension = map toLower (takeExtension path)
        path = infoPath info

countDirectories :: Iterator Integer        
countDirectories count info =
    Continue (if isDirectory info
                then count + 1
                else count)