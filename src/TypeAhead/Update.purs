module TypeAhead.Update where

import Prelude ((<<<))

import Pux (noEffects)

import TypeAhead.States (StateTA)

data ActionTA a = UpdateElement a

simpleUpdateTA :: forall f a. ActionTA a -> StateTA f a (ActionTA a) -> StateTA f a (ActionTA a)
simpleUpdateTA (UpdateElement newElement) state = state

updateTA action = noEffects <<< (simpleUpdateTA action)
