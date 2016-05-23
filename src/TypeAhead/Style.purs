module TypeAhead.Style where

import Prelude (bind,(#))

import CSS

boldText = fontWeight bold

inputStyle = do
  position relative
  display inlineBlock
  sym padding (10.0 # px)

optionsStyle = do
  display block
  position absolute
  backgroundColor white
  border solid (1.0 # px) grey
  sym borderRadius (2.0 # px)
