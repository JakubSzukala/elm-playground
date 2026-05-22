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
  { newId = 0, newTitle = "", events = [] }



-- UPDATE


type Msg
  = Add
  | Remove Int
  | Decrement
  | Title String -- This effectively is function String -> Msg


update : Msg -> Model -> Model
update msg model =
  case msg of
    Add ->
      { newTitle = ""
      , newId = model.newId + 1
      , events = { id = model.newId, title = model.newTitle } :: model.events
      }

    Remove id ->
      { model | events = List.filter (\e -> e.id /= id) model.events }

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


titleView : Event -> Html Msg
titleView event =
  div [ style "color" "green" ]
    [ text (String.fromInt event.id ++ ": " ++ event.title)
    , button [ onClick (Remove event.id) ] [ text "-" ]
    ]


titleViews : List Event -> Html Msg
titleViews events =
  ul [] (List.map titleView events)
