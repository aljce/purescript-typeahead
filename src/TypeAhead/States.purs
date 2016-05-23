module TypeAhead.States
       ( testState,
         twitterTA
       ) where

import Prelude hiding ((#),div,bind)

import Data.Either
import Data.String as S
import Data.String.Regex as R
import Data.Array as A
import Data.Foldable as F

import Pux
import Pux.Html hiding (map,filter,style)
import Pux.Html.Attributes hiding (filter,style)
import Pux.Html.Events (onChange)
import Pux.CSS (style)

import TypeAhead.Types
import TypeAhead.Update
import TypeAhead.Style

testState :: StateTA Array String ActionTA
testState = StateTA {
  _buildElem: id,
  _element: "Testing",
  _renderElem: text,
  _showOptions: (\_ opts -> map text opts),
  _options: [ "Kyle", "James", "Andrew" ] }

inputBox :: String -> Html ActionTA
inputBox str = div # do
  input [ type_ "text", value str, onChange UpdateElement ] []

search :: String -> String -> Array (Either String String)
search substr = map toEither <<< A.filter (not <<< S.null) <<< R.split (R.regex captured flags)
  where captured = "(" ++ substr ++ ")"
        flags    = R.noFlags { ignoreCase = true }
        toEither str
          | S.toLower substr == S.toLower str = Right substr
          | otherwise     = Left str

renderOptions :: String -> Array String -> Array (Html ActionTA)
renderOptions searchStr = map toHtml <<<
                          A.filter (F.any (either (const false) (const true))) <<<
                          map (search searchStr)
  where toHtml sections = li [] (map bolden sections)
        bolden (Left normal) = span # text normal
        bolden (Right match) = span ! style boldText # text match

twitterTA :: Array String -> StateTA Array String ActionTA
twitterTA opts = StateTA {
  _buildElem: id,
  _element: "",
  _renderElem: inputBox,
  _showOptions: renderOptions,
  _options: opts }
