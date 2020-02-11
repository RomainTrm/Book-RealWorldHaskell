module BetterPredicate where

import Control.Monad (filterM)
import System.Directory (Permissions(..), getModificationTime, getPermissions)
import Data.Time.Clock (UTCTime(..))
import System.FilePath (takeExtension)
import Control.Exception (IOException, bracket, handle)
import System.IO (IOMode(..), hClose, hFileSize, openFile)

-- the function we wrote earlier
import RecursiveContents (getRecursiveContents)

type Predicate =  FilePath      -- path to directory entry
               -> Permissions   -- permissions
               -> Maybe Integer -- file size (Nothing if not file)
               -> UTCTime       -- last modified
               -> Bool

-- Returns an exception if trying to read fileSize on a directory
simpleFileSize :: FilePath -> IO Integer
simpleFileSize path = do
    h <- openFile path ReadMode
    size <- hFileSize h
    hClose h
    return size

noSize :: IOException -> IO (Maybe Integer)
noSize _ = return Nothing

-- Could never close a file in case of failure while reading size
saferFileSize :: FilePath -> IO (Maybe Integer)
saferFileSize path = handle noSize $ do
    h <- openFile path ReadMode
    size <- hFileSize h
    hClose h
    return (Just size)

-- Catches exceptions and always close files
getFileSize :: FilePath -> IO (Maybe Integer)
getFileSize path = handle noSize $
  bracket (openFile path ReadMode) hClose $ \h -> do
    size <- hFileSize h
    return (Just size)

-- Exercises
-- 1. Is the order in which we call bracket and handle important? Why?
-- Yes, because bracket apply close and then send the return of the fonction (result or exception)
-- If it's an exception, we have to catch it with handle 

betterFind :: Predicate -> FilePath -> IO [FilePath]
betterFind p path = getRecursiveContents path >>= filterM check
    where check name = do
            perms <- getPermissions name
            size <- getFileSize name
            modified <- getModificationTime name
            return (p name perms size modified)

type InfoP a =  FilePath        -- path to directory entry
             -> Permissions     -- permissions
             -> Maybe Integer   -- file size (Nothing if not file)
             -> UTCTime         -- last modified
             -> a

pathP :: InfoP FilePath
pathP path _ _ _ = path

sizeP :: InfoP Integer
sizeP _ _ (Just size) _ = size
sizeP _ _ Nothing     _ = -1

liftP :: (a -> b -> c) -> InfoP a -> b -> InfoP c
liftP q f k w x y z = f w x y z `q` k

equalP :: (Eq a) => InfoP a -> a -> InfoP Bool
equalP = liftP (==)
(==?) = equalP

greaterP, lesserP :: (Ord a) => InfoP a -> a -> InfoP Bool
greaterP = liftP (>)
(>?) = greaterP
lesserP = liftP (<)

liftP2 :: (a -> b -> c) -> InfoP a -> InfoP b -> InfoP c
liftP2 q f g w x y z = f w x y z `q` g w x y z

andP = liftP2 (&&)
(&&?) = andP
orP = liftP2 (||)

liftPath :: (FilePath -> a) -> InfoP a
liftPath f w _ _ _ = f w


myTest3 = (liftPath takeExtension ==? ".cpp") &&? (sizeP >? 131072)

-- Define fixity for our operators so we don't need to specify operators order with parentheses
-- without parentheses, previous expression would have been interpreted like this :
-- (((liftPath takeExtension) ==? ".cpp") &&? sizeP) >? 131072

infix 4 ==?
infixr 3 &&?
infix 4 >?

myTest4 = liftPath takeExtension ==? ".cpp" &&? sizeP >? 131072