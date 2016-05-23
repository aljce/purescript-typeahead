module Main where

import Prelude (bind)

import Pux (start, renderToDOM)

import TypeAhead.States (twitterTA)
import TypeAhead.Render (renderTA)
import TypeAhead.Update (updateTA)

testOptions = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District Of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota","Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]

main = do
  app <- start {
    initialState: twitterTA testOptions,
    update: updateTA,
    view: renderTA,
    inputs: []
               }
  renderToDOM "#app" app.html
