module Main where

import Prelude (bind)

import Pux (start, renderToDOM)

import TypeAhead.States (twitterTA)
import TypeAhead.Render (renderTA)
import TypeAhead.Update (updateTA)

testOptions = ["Kyle","James","Andrew"]

main = do
  app <- start {
    initialState: twitterTA testOptions,
    update: updateTA,
    view: renderTA,
    inputs: []
               }
  renderToDOM "#app" app.html
