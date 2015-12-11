-- By: Jamison and Russ .... but mostly Jamison

module Main where

import Html exposing (div, text, Html)
import StartApp.Simple as StartApp
import Signal exposing (Address, forwardTo)
import Components.GenericList as GenericList

-- # Main

main =
  StartApp.start { model = model, view = view, update = update }

-- # Model

type alias Model = {
    naughty : GenericList.Model,
    nice : GenericList.Model
  }
model : Model
model = { naughty = GenericList.model, nice = GenericList.model }

-- # Actions
type NaughtyOrNice = Naughty | Nice

type Action = Update NaughtyOrNice GenericList.Action

update : Action -> Model -> Model
update action model =
  case action of
    Update naughtyOrNice action ->
      case naughtyOrNice of
        Naughty -> { model | naughty = GenericList.update action model.naughty }
        Nice -> { model | nice = GenericList.update action model.nice }

-- # View

translateNaughtyAction : GenericList.Action -> Action
translateNaughtyAction action = Update Naughty action

translateNiceAction : GenericList.Action -> Action
translateNiceAction action = Update Nice action


view : Address Action -> Model -> Html
view address model =
  div [] [
    div [] [GenericList.view (forwardTo address translateNaughtyAction) model.naughty],
    div [] [GenericList.view (forwardTo address translateNiceAction) model.nice]
  ]
