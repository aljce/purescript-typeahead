module TypeAhead.Style where

import Prelude (bind)

import CSS

boldText = fontWeight bold

inputStyle = do
  position relative
  display inlineBlock

optionsStyle = do
  display block
  position absolute
  backgroundColor white



