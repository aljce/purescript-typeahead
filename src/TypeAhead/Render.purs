module TypeAhead.Render where

import Data.Lens ((^.))

import Pux.Html (div,(#),(!),bind,Html)
import Pux.CSS (style)

import TypeAhead.Types (StateTA,options,element,showOptions,renderElem,mainCSS)

renderTA :: forall f a act. StateTA f a act -> Html act
renderTA state = do
  div # do
    div ! style (state ^. mainCSS) # do
      (state ^. renderElem) (state ^. element)
      (state ^. showOptions) (state ^. element) (state ^. options)
