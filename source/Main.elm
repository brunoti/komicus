module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Url.Parser as UP exposing (Parser, (</>), int, map, oneOf, s, string)
import Routing
import Url

import View.Base as Base

main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view >> toUnstyledDocument
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }

-- MODEL
type alias Model =
  { key   : Nav.Key
  , url   : Url.Url 
  , route : Routing.Route
  }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
  ({ key = key
  , url = url
  , route = Routing.toRoute (Url.toString url)
  }, Cmd.none )

-- UPDATE
type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      ( { model | url = url, route = Routing.toRoute (Url.toString url) }
      , Cmd.none
      )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

toUnstyledDocument : Document msg -> Browser.Document msg
toUnstyledDocument doc =
    { title = doc.title
    , body = List.map toUnstyled doc.body
    }

-- VIEW
view : Model -> Document Msg
view model =
  let
      route = zica model
  in
  { title = route.title
  , body = Base.view route.body
  }


type alias Document msg = 
  { title : String
  , body : List (Html msg)
  }

zica : Model -> Document Msg
zica model =
  case model.route of
    Routing.Home -> 
      { title = "Home"
      , body = [ div [] [ text "Home" ] ]
      }
    Routing.About -> 
      { title = "About"
      , body = [ div [] [ text "About" ] ]
      }
    Routing.NotFound -> 
      { title = "Not Found"
      , body = [ div [] [ text "Not Found" ] ]
      }

viewLink : String -> Html msg
viewLink path =
  li [] [ a [ href path ] [ text path ] ]
