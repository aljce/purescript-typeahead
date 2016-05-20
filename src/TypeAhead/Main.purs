module Main where

import Prelude (bind,id,map)

import Pux (start, renderToDOM)
import Pux.Html (text)

import TypeAhead.States
import TypeAhead.Render (renderTA)
import TypeAhead.Update (updateTA, ActionTA)

testState :: StateTA Array String (ActionTA String)
testState = StateTA {
  _buildElem: id,
  _element: "Testing",
  _renderElem: text,
  _showOptions: (\_ opts -> map text opts),
  _options: [ "Kyle", "James", "Andrew" ] }

main = do
  app <- start {
    initialState: testState,
    update: updateTA,
    view: renderTA,
    inputs: []
               }
  renderToDOM "#app" app.html
