module Main exposing (..)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { newId : Int
  , newTitle : String
  , events : List Event
  }


type alias Event =
  { id : Int
  , title : String
  }


init : Model
init =
  { newId = -1, newTitle = "", events = [] }



-- UPDATE


type Msg
  = Add
  --| Remove
  | Decrement
  | Title String -- This effectively is function String -> Msg


update : Msg -> Model -> Model
update msg model =
  case msg of
    Add ->
      { newTitle = "", newId = model.newId + 1, events = model.newTitle :: model.events }

    Decrement ->
      { model | newId = model.newId - 1 }

    Title title ->
      { model | newTitle = title }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ div [] [ text (String.fromInt model.newId) ]
    , button [ onClick Decrement ] [ text "-" ]
    , button [ onClick Add ] [ text "+" ]
    , input [ type_ "text", placeholder "Title", value model.newTitle, onInput Title ] []
    , titleViews model.events
    ]


-- TODO: We could nest some stuff here, for example date and remove button
titleView : String -> Html msg
titleView title =
  div [ style "color" "green" ]
    [ text title
    --, button [ onClick Remove ] [ text "-" ]
    ]


titleViews : List String -> Html msg
titleViews events =
  ul [] (List.map titleView events)
