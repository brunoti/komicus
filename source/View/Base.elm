module View.Base exposing (view)

import Css exposing (..)
import Html.Styled exposing (..)
import Components.Menu as Menu
import Theme.Color


container : List (Attribute msg) -> List (Html msg) -> Html msg
container = 
  styled div
  [ marginLeft (px 240)
  , paddingLeft (px 75)
  , paddingRight (px 15)
  , paddingTop (px 15)
  , paddingBottom (px 15)
  , backgroundColor Theme.Color.foreground
  , flex (int 1)
  , borderRadius (px 20)
  ]


view : List (Html msg) -> List (Html msg)
view content =
  [ Menu.view
  , container [] content
  ]
  

