module Test where

import Prelude ((+),otherwise,(<),(<=),(==),(++),(<<<),map,not)

import Data.Either
import Data.Maybe

import Data.String as S
import Data.String.Regex as R
import Data.Array


search :: String -> String -> Array (Either String String)
search substr = map toEither <<< filter (not <<< S.null) <<< R.split (R.regex captured flags)
  where captured = "(" ++ substr ++ ")"
        flags    = R.noFlags { ignoreCase = true }
        toEither str
          | substr == str = Right substr
          | otherwise     = Left str
