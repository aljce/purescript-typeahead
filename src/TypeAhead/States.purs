module TypeAhead.States
       ( twitterTA
       ) where

import Prelude (id,map,const,(<<<),not,otherwise,(==),(++))

import Data.Either (Either(..), either)
import Data.String as S
import Data.String.Regex as R
import Data.Array as A
import Data.Foldable as F

import Pux.Html (Html,ul,(#),(!),div,span,text,li,input)
import Pux.Html.Attributes (value,type_)
import Pux.Html.Events (onChange)
import Pux.CSS (style)

import TypeAhead.Types (StateTA(StateTA))
import TypeAhead.Update (ActionTA(UpdateElement))
import TypeAhead.Style (inputStyle,optionsStyle,boldText)

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

buildList :: String -> Array String -> Array (Html ActionTA)
buildList searchStr = map toHtml <<<
                          A.filter (F.any (either (const false) (const true))) <<<
                          map (search searchStr)
  where toHtml sections = li [] (map bolden sections)
        bolden (Left normal) = span # text normal
        bolden (Right match) = span ! style boldText # text match

renderOptions :: String -> Array String -> Html ActionTA
renderOptions searchStr opts = case A.null renderedOpts of
  true  -> span [] []
  false -> div ! style optionsStyle # do
    ul [] renderedOpts
  where renderedOpts = buildList searchStr opts


twitterTA :: Array String -> StateTA Array String ActionTA
twitterTA opts = StateTA {
  _buildElem: id,
  _mainCSS: inputStyle,
  _element: "",
  _renderElem: inputBox,
  _showOptions: renderOptions,
  _options: opts }
