module ControlledVisit where

import Control.Monad (forM, liftM)
import System.Directory (Permissions(..), getPermissions, getDirectoryContents, getModificationTime)
import Data.Time.Clock (UTCTime(..))
import System.FilePath ((</>))
import Control.Exception (IOException, bracket, handle)
import System.IO (IOMode(..), hClose, hFileSize, openFile)
import Prelude hiding (traverse)
import Data.List (sortOn, reverse)
import BetterPredicate 

data Info = Info {
      infoPath :: FilePath
    , infoPerms :: Maybe Permissions
    , infoSize :: Maybe Integer
    , infoModTime :: Maybe UTCTime
    } deriving (Eq, Ord, Show)

traverse :: ([Info] -> [Info]) -> FilePath -> IO [Info]
traverse order path = do
    names <- getUsefulContents path
    contents <- mapM getInfo (path : map (path </>) names)
    liftM concat $ forM (order contents) $ \info -> do
      if isDirectory info && infoPath info /= path
        then traverse order (infoPath info)
        else return [info]

getUsefulContents :: FilePath -> IO [String]
getUsefulContents path = do
    names <- getDirectoryContents path
    return (filter (`notElem` [".", ".."]) names)

isDirectory :: Info -> Bool
isDirectory = maybe False searchable . infoPerms

nothingIO :: IOException -> IO (Maybe a)
nothingIO _ = return Nothing

maybeIO :: IO a -> IO (Maybe a)
maybeIO act = handle nothingIO (Just `liftM` act)

getInfo :: FilePath -> IO Info
getInfo path = do
  perms <- maybeIO (getPermissions path)
  size <- maybeIO (bracket (openFile path ReadMode) hClose hFileSize)
  modified <- maybeIO (getModificationTime path)
  return (Info path perms size modified)

-- 1. What should you pass to traverse to traverse a directory tree in reverse alphabetic order? 

alphatetical :: [Info] -> [Info]
alphatetical infos = sortOn infoPath infos

reverseAlphatetical :: [Info] -> [Info]
reverseAlphatetical infos = reverse $ alphatetical infos

-- 2. Using id as a control function, traverse id performs a preorder traversal of a tree: it returns a parent directory before its children. 
--    Write a control function that makes traverse perform a postorder traversal, in which it returns children before their parent.

postOrder :: [Info] -> [Info]
postOrder infos = tail infos ++ [head infos]

-- 3. Take the predicates and combinators from the section called “Gluing predicates together” and make them work with our new Info type. 

info2infoP :: InfoP a -> Info -> a
info2infoP f (Info path (Just perm) size (Just time)) = f path perm size time

-- 4. Write a wrapper for traverse that lets you control traversal using one predicate, and filter results using another. 

traverseThenFilter :: ([Info] -> [Info]) -> InfoP Bool -> FilePath -> IO [Info]
traverseThenFilter order f path = do
    infos <- traverse order path
    return $ (filter $ info2infoP f) infos