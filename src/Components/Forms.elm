module Components.Forms exposing (main)

import Browser
import Debug exposing (log)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- Main


main =
    Browser.sandbox { init = init, update = update, view = view }



-- Model


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    Model "" "" ""



-- Update


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- View


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewValidation model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if String.length model.password < 8 then
        div [ style "color" " orange" ] [ text "Check that the password is longer than 8 characters." ]

    else if isValid model.password > 0 then
        div [ style "color" " orange" ] [ text "Make sure the password contains upper case, lower case, and numeric characters." ]

    else if model.password == model.passwordAgain then
        div [ style "color" " green" ] [ text "OK" ]

    else
        div [ style "color" " red" ] [ text "Passwords do not match" ]


test =
    "hello"


isValid : String -> String -> Int
isValid password =
    String.filter Char.isDigit
        |> String.filter Char.isUpper
        |> String.filter Char.isLower
        |> String.length
