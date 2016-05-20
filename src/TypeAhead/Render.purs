module TypeAhead.Render where

import Prelude (class Show, show, map, (<<<))

import Data.Lens ((^.))

import Data.Foldable (class Foldable, foldMap)

import Data.Array (singleton)

import Pux
import Pux.Html hiding (map,element)

import TypeAhead.States

renderTA :: forall f a act. (Foldable f) => StateTA f a act -> Html act
renderTA state = do
  div # do
    (state ^. renderElem) (state ^. element)
    ul [] (foldMap singleton renderedOpts)
  where renderedOpts = (state ^. showOptions) (state ^. element) (state ^. options)
