module Main (main) where

import SimpleJSON
import PutJSON
import PrettyJSON
import Prettify

main = putJValue (JObject [("foo", JNumber 1), ("bar", JBool False)])