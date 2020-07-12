module Components.Menu exposing (view)

import String
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (href, class)
import Theme.Color

menu : List (Attribute msg) -> List (Html msg) -> Html msg
menu = 
  styled div
  [ position fixed
  , width (px 300)
  , top (px 50)
  , bottom (px 50)
  , left (px 50)
  , backgroundColor Theme.Color.background
  , borderRadius (px 20)
  ]

item : String -> String -> Html msg
item url name =
  styled div
    [ after
      [ backgroundImage (linearGradient2 toRight (stop <| hex "#262626") (stop <| hex "#FFFFFF") [])
      , height (px 1)
      , width (pct 100)
      , display block
      ]
      , marginLeft (px 50)
    ] [ class "use-after" ] [ link url name ]

link : String -> String -> Html msg
link url name = 
      styled a
        [ lineHeight (px 30)
        , display block
        , fontSize (Css.em 0.9)
        , textAlign right
        , color (hex "#FFF")
        , textDecoration none
        , paddingRight (px 10)
        ]
        [ href url ]
        [ text (String.toUpper name) ]

title : List (Attribute msg) -> List (Html msg) -> Html msg
title = 
  styled h1
  [ color (hex "#FFF")
  , textAlign center
  ]



view : (Html msg)
view = menu []
  [ title [] [ text "Komicus" ]
  , item "/" "Home"
  , item "/categories" "Categories"
  , item "/about" "About"
  ]
