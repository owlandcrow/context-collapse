module Test exposing (main)

-- Trivial app that convinces Docker to cache
-- elm.json's dependencies

import Browser
import Html
main : Program () Model Msg
main =
    Browser.sandbox
        { init = ()
        , view = Html.div [] []
        , update = \() () -> ()
        }
