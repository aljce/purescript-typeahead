module TypeAhead.Render where

import Prelude (class Show, show, map, (<<<))

import Data.Lens ((^.))

import Data.Foldable (class Foldable, foldMap)

import Data.Array (singleton,null)

import Pux
import Pux.Html hiding (map,element)
import Pux.CSS (style,display,displayNone)

import TypeAhead.Types
import TypeAhead.Style

renderTA :: forall f a act. (Foldable f) => StateTA f a act -> Html act
renderTA state = do
  div # do
    div ! style inputStyle # do
      (state ^. renderElem) (state ^. element)
      case null opts of
           true  -> span [] []
           false -> div ! style optionsStyle # do
             ul [] (foldMap singleton renderedOpts)
    div # do
      text "background"
  where opts = foldMap singleton renderedOpts
        renderedOpts = (state ^. showOptions) (state ^. element) (state ^. options)
