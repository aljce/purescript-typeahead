module TypeAhead.Update where

import Prelude ((<<<),(#))

import Data.Lens (view, (.~))

import Pux (noEffects)
import Pux.Html.Events (FormEvent)
import TypeAhead.Types (StateTA,element,buildElem)

newtype ActionTA = UpdateElement FormEvent

simpleUpdateTA :: forall f a. ActionTA -> StateTA f a ActionTA -> StateTA f a ActionTA 
simpleUpdateTA (UpdateElement ev) state =
  state # element .~ (view buildElem state ev.target.value)

updateTA action = noEffects <<< simpleUpdateTA action
