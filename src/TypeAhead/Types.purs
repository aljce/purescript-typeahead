module TypeAhead.Types where

import Prelude (map)

import Pux.Html (Html)
import CSS (CSS)

import Data.Lens (LensP,lens)

data StateTA f a act = StateTA {
  _buildElem   :: (String -> a),
  _mainCSS     :: CSS,
  _element     :: a,
  _renderElem  :: (a -> Html act),
  _showOptions :: (a -> f a -> Html act),
  _options     :: (f a) }

buildElem :: forall f a act. LensP (StateTA f a act) (String -> a)
buildElem = lens getter setter
  where getter (StateTA { _buildElem: bElem }) = bElem
        setter (StateTA state) bElem = StateTA (state { _buildElem = bElem })

mainCSS :: forall f a act. LensP (StateTA f a act) CSS
mainCSS = lens getter setter
  where getter (StateTA { _mainCSS: css }) = css
        setter (StateTA state) css = StateTA (state { _mainCSS = css })

element :: forall f a act. LensP (StateTA f a act) a
element = lens getter setter
  where getter (StateTA { _element: elem }) = elem
        setter (StateTA state) elem = StateTA (state { _element = elem })

renderElem :: forall f a act. LensP (StateTA f a act) (a -> Html act)
renderElem = lens getter setter
  where getter (StateTA { _renderElem: rElem }) = rElem
        setter (StateTA state) rElem = StateTA (state { _renderElem = rElem })

showOptions :: forall f a act. LensP (StateTA f a act) (a -> f a -> Html act)
showOptions = lens getter setter
  where getter (StateTA { _showOptions: sOpts }) = sOpts
        setter (StateTA state) sOpts = StateTA (state { _showOptions = sOpts })

options :: forall f a act. LensP (StateTA f a act) (f a)
options = lens getter setter
  where getter (StateTA { _options: opts }) = opts
        setter (StateTA state) opts = StateTA (state { _options = opts })
