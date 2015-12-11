module Components.GenericList where

import Html exposing (div, text, input, button, Html)
import Signal exposing (Address)
import Html.Events exposing (on, onClick, targetValue)


-- # Model

type alias Model =
  {
    names : List String,
    tooInput : String
  }
model : Model
model = { names = [], tooInput = "" }

-- # Actions

type Action
    = Insert
    | Input String

update : Action -> Model -> Model
update action model =
  case action of
    Insert -> { model |
                  names = model.names ++ [model.tooInput],
                  tooInput = ""
              }
    Input name -> { model | tooInput = name }


renderName : String -> Html
renderName name = text name


-- # View


view : Address Action -> Model -> Html
view address model =
  div [] [
    div [] [
      input [on "input" targetValue (Signal.message address << Input)] [],
      button [onClick address Insert] [text "Add"]
    ],
    div [] (List.map renderName model.names)
  ]
